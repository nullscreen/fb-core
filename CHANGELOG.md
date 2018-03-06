# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check
[Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).


## 1.0.0.beta2  - 2018/03/06

* [FEATURE] Add `impressions` to `Fb::Post` for number of impressions of a post.

## 1.0.0.beta1  - 2018/02/14

* [ENHANCEMENT] Fix and use Page Access Token when request page insights.

## 1.0.0.alpha12  - 2017/12/08

* [FEATURE] Add `Fb::Video` and `Fb::Page#videos`
* [FEATURE] Add fields of "/videos" endpoint such as `comment_count`, `length` etc to `Fb::Video`
* [FEATURE] Add metrics from "/video_insights" endpoint such as `total_views` to `Fb::Video`

## 1.0.0.alpha11  - 2017/12/01

* [FEATURE] Add `share_count` to `Fb::Post` for number of shares of a post.

## 1.0.0.alpha10  - 2017/09/07

* [FEATURE] Add `comment_count`, `like_count`, and `reaction_count` to `Fb::Post` for number of comments, number of likes, and number of reactions of a post.

## 1.0.0  - 2017/07/24

* [FEATURE] Added `Fb::User`
* [FEATURE] Added `Fb::Page`
* [FEATURE] Added `Fb::Page#posts`
* [FEATURE] Added `Fb::Page#like_count`
* [FEATURE] Added `Fb::Page#view_count`
* [FEATURE] Added `Fb::Page#weekly_insights`
* [FEATURE] Added `Fb::Page#metric_insights`
