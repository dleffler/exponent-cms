<?php

##################################################
#
# Copyright (c) 2004-2008 OIC Group, Inc.
# Written and Designed by Adam Kessler
#
# This file is part of Exponent
#
# Exponent is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License as published by the Free
# Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# GPL: http://www.gnu.org/licenses/gpl.txt
#
##################################################

class newsController extends expController {
    public $useractions = array(
        'showall'=>'Show all News',
    );

    public $remove_configs = array('ealerts','tags','comments','files');

    public $add_permissions = array('showUnpublished'=>'View Unpublished News');
    private $sortopts = array(
                        'DESC'=>'Newest Posts First', 
                        'ASC'=>'Oldest First', 
                        'rank'=>'I will sort them manually'
    );
    

    function name() { return $this->displayname(); } //for backwards compat with old modules
    function displayname() { return "News"; }
    function description() { return "Use this to display & manage news type content on your site."; }
    function author() { return "Adam Kessler - OIC Group, Inc"; }
    function hasSources() { return true; }
    function hasViews() { return true; }
    function hasContent() { return true; }
    function supportsWorkflow() { return false; }
    function isSearchable() { return true; }
    
    public function showall() { 
        expHistory::set('viewable', $this->params);

        $modelname = $this->basemodel_name;
        
        // setup the where clause for looking up records.
        $where = "(publish = 0 or publish <= " . time() . ") AND (unpublish=0 OR unpublish > ".time().") AND ".$this->aggregateWhereClause();
        if (isset($this->config['only_featured'])) $where .= ' AND is_featured=1';      
        
        // figure out if should limit the results
        if (isset($this->params['limit'])) {
            $limit = $this->params['limit'] == 'none' ? null : $this->params['limit'];
        } else {
            $limit = isset($this->config['limit']) ? $this->config['limit'] : null;
        }       
        
        // set the sort order of the records.
        $order = 'publish';
        if (empty($this->config['order'])) {            
            $order_dir = 'DESC';
        } elseif ($this->config['order'] == 'rank') {
             $order = 'rank';
             $order_dir = 'ASC';
        } else {
            $order_dir = $this->config['order'];
        }
        
        // pull the news posts from the database 
        $items = $this->$modelname->find('all', $where, $order.' '.$order_dir);  
        
        // merge in any RSS news and perform the sort and limit the number of posts we return to the configured amount.
        if (!empty($this->config['pull_rss'])) $items = $this->mergeRssData($items);
        
        // setup the pagination object to paginate the news stories.
        $page = new expPaginator(array(
            //'model'=>'news',
            'records'=>$items,
            'limit'=>$limit,
            'order'=>$order,
            'dir'=>$order_dir,
            'controller'=>$this->baseclassname,
            'action'=>$this->params['action'],
            'src'=>$this->loc->src,
            'view'=>empty($this->params['view']) ? null : $this->params['view']
            ));
            
        $morenews = (count($items) > $this->config['limit']) ? 1 : 0;

        assign_to_template(array(
            'morenews'=>$morenews,
            'page'=>$page,
            'items'=>$items,
            'modelname'=>$modelname,
            'enable_rss'=>empty($this->config['enable_rss']) ? false : true,
        ));
    }
    
    public function showUnpublished() {
        expHistory::set('viewable', $this->params);
        
        $modelname = $this->basemodel_name;
        
        // setup the where clause for looking up records.
        $where  = "(unpublish != 0 AND unpublish < ".time().") OR (publish > ".time().")";
        $where .= "AND ".$this->aggregateWhereClause();
        
        $page = new expPaginator(array(
            'model'=>'news',
            'where'=>$where, 
            'limit'=>25,
            'order'=>'unpublish',
            'controller'=>$this->baseclassname,
            'action'=>$this->params['action'],
            'columns'=>array('Title'=>'title','Published On'=>'publish', 'Status'=>'unpublish'),
            ));
            
        assign_to_template(array('page'=>$page));
    }
    
    public function showExpired() {
        redirect_to(array('controller'=>'news', 'action'=>'showUnpublished','src'=>$this->params['src']));
    }
    
    public function configure() {
        parent::configure();
        assign_to_template(array('sortopts'=>$this->sortopts));
    }
    
    public function saveConfig() { 
        if (!empty($this->params['aggregate']) || !empty($this->params['pull_rss'])) {
            if ($this->params['order'] == 'rank ASC') {
                expValidator::failAndReturnToForm('User defined ranking is not allowed when aggregating or pull RSS data feeds.', $this->params);
            }
        }
        
        parent::saveConfig();
    }
    
    public function getRSSContent() {
        global $db;     
    
        // setup the where clause for looking up records.
        $where = "(publish = 0 or publish <= " . time() . ") AND (unpublish=0 OR unpublish > ".time().") AND ".$this->aggregateWhereClause();
        if (isset($this->config['only_featured'])) $where .= ' AND is_featured=1';

        // set the sort order of the records.
        $order = 'publish';
        $order_dir = '';
        if (empty($this->config['order'])) {            
            $order_dir = 'DESC';
        } elseif ($this->config['order'] == 'rank') {
             $order = 'rank';
             $order_dir = 'ASC';
        } else {
            $order_dir = $this->config['order'];
        }
        // pull the news posts from the database 
        $items = $this->news->find('all', $where, $order.' '.$order_dir);  
        
        //Convert the newsitems to rss items
        $rssitems = array();
        foreach ($items as $key => $item) { 
            $rss_item = new FeedItem();
            $rss_item->title = $item->title;
            $rss_item->description = $item->body;
            $rss_item->date = date('r',$item->publish_date);
            $rss_item->link = makeLink(array('controller'=>'news', 'action'=>'showByTitle', 'title'=>$item->sef_url));
            $rssitems[$key] = $rss_item;
        }
        return $rssitems;
    }
    
    private function mergeRssData($items) {
        if (!empty($this->config['pull_rss'])) {    
            if (isset($this->config['rss_cachetime']) && $this->config['rss_cachetime'] != 3600) define('MAGPIE_CACHE_AGE', $this->config['rss_cachetime']);
            
            $RSS = new rssfeed();
            $news = array();
            foreach($this->config['pull_rss'] as $url) {
                $RSS->setURL($url);
                $feed = $RSS->fetch();
                if (!$feed) {
                    // an error occured in the rss.
                    continue;
                }
                foreach ($feed->items as $rssItem) {
                    $rssObject = new stdClass();
                    $rssObject->title = !empty($rssItem['title']) ? $rssItem['title'] : "";
                    $rssObject->body = !empty($rssItem['description']) ? $rssItem['description'] : "";
                    $rssObject->rss_link = !empty($rssItem['link']) ? $rssItem['link'] : "";
                    $rssObject->publish = !empty($rssItem['date_timestamp']) ? $rssItem['date_timestamp'] : "";
                    $rssObject->isRss = true;
                    $news[] = $rssObject;
                }
            }
            $items = array_merge($items, $news);
        }
        return $items;
    }
    
    private function sortDescending($a,$b) {
        return ($a->publish_date > $b->publish_date ? -1 : 1);
    }

    private function sortAscending($a,$b) {
        return ($a->publish_date < $b->publish_date ? -1 : 1);
    }
}
?>
