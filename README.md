# Fb::Core

Fb::Core provides methods to interact with Facebook users and pages through the Facebook Graph API.

[![Build Status](http://img.shields.io/travis/Fullscreen/fb-core/master.svg)](https://travis-ci.org/Fullscreen/fb-core)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/fb-core/master.svg)](https://coveralls.io/r/Fullscreen/fb-core)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/fb-core.svg)](https://gemnasium.com/Fullscreen/fb-core)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/fb-core.svg)](https://codeclimate.com/github/Fullscreen/fb-core)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/fb-core/frames)
[![Gem Version](http://img.shields.io/gem/v/fb-core.svg)](http://rubygems.org/gems/fb-core)

The **source code** is available on [GitHub](https://github.com/Fullscreen/fb-core) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/fb-core/frames).

### Installing and Configuring

Add `fb-core` to your Gemfile and run `bundle install`.

Most methods of this library require to have an access token of a Facebook user.
If you need to obtain one programmatically, use the [fb-auth](https://github.com/Fullscreen/fb-auth) library.

## Usage

Fb::User#email
--------------

Given an user access token with the `email` scope, you can get the user's email by calling:

```ruby
user = Fb::User.new access_token: '--valid-access-token--'
user.email # => 'john.smith@example.com'
```

Fb::User#pages
--------------

Given an user access token with the `pages_show_list` scope, you can get the list of Facebook pages managed by the user by calling:

```ruby
user = Fb::User.new access_token: '--valid-access-token--'
user.pages
# => [#<Fb::Page: id="1234", name="sample1">, #<Fb::Page: id="5678", name="sample2">]
```

Fb::Page#posts
--------------

Given a page with posts, you can get the posts on the page since creation by calling:

```ruby
page = Fb::Page.new access_token: '--valid-access-token--', id: '--valid-id--'
page.posts
# => [#<Fb::Post: id="1234", type="video">, #<Fb::Post: id="5678", type="video">]
```

Fb::Page#like_count
--------------

Given a page, you can get the the number of likes for the page.

```ruby
page = Fb::Page.new access_token: '--valid-access-token--', id: '--valid-id--'
page.like_count
# => 15000
```

Pass an `until` (`Date`) option to get the count at a certain date.

```ruby
page.like_count until: Date.today - 7
# => 10000
```

Fb::Page#view_count
--------------

You can also get the the number of views for the page.

```ruby
page = Fb::Page.new access_token: '--valid-access-token--', id: '--valid-id--'
page.view_count
# => 12345
```

Pass an `until` (`Date`) option to get the count at a certain date.

```ruby
page.view_count until: Date.today - 7
# => 10000
```

Fb::Page#weekly_insights
--------------

`weekly_insights` allows you to get metrics that are available weekly such as
`page_views_total`, `page_impressions`, `page_fan_adds`, etc. Refer to
[metrics](https://developers.facebook.com/docs/graph-api/reference/v2.9/insights#availmetrics)
for a list of available weekly metrics.

This method takes an array metrics and returns a hash of the metrics mapped to
their values. Each metric value is the sum of the last 7 days. If today is July 20th,
then the values will be for July 14 - July 20.

```ruby
metrics = %i(page_impressions page_fan_adds)
page = Fb::Page.new access_token: '--valid-access-token--', id: '--valid-id--'
page.weekly_insights metrics # sum for July 14 - 20
# => {:page_impressions => 1234, :page_fan_adds => 5678}
```

Pass an `until` (`Date`) option such as `Date.today - 7` to fetch 7 days prior to July 14th.

```ruby
page.weekly_insights metrics, until: Date.today - 7  # sum for July 8 - 14
# => {:page_impressions => 1234, :page_fan_adds => 5678}
```

Fb::Page#metric_insights
--------------

You can get an individual metric through using `metric_insights` which takes a
metric, period, and options (since & until). Refer to
[metrics](https://developers.facebook.com/docs/graph-api/reference/v2.9/insights#availmetrics)
for a list of available weekly metrics and periods.

**Ensure that the period that you are using is supported by the metric**.
For example, `page_views_total` (page views) is available for `week`, `week`, and `days_28`
whereas `page_fans` (page likes) is only available as `lifetime`.

`metric_insights` returns a hash of Dates mapped to values. Passing `since` only return dates ahead
to this date (lower bound) and passing `until` will return dates previous to this day
(upper bound & defaults to 2 days ago). Combining both options will return the dates in between.

```ruby
page = Fb::Page.new access_token: '--valid-access-token--', id: '--valid-id--'
metric_insights = page.metric_insights 'page_views_total', :day # let today be August 7th
# => {#<Date: 2017-08-04> => 598, <Date: 2017-08-05> => 548}
```

With `until` (`Date`) and `since` (`Date`).

```ruby
options = {since: Date.today - 9, until: Date.today}
metric_insights = page.metric_insights metric, :day, options
# => {#<Date: 2017-08-01> => 639,..,#<Date: 2017-08-05 => 548}
```

## Development

To run tests, obtain a long-term access token for a Facebook user who manages
at least one page and includes `email` and `manage_pages` scopes. Set the token as:

    export FB_TEST_ACCESS_TOKEN="YourToken"

Then, run `rake spec` to run the tests.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Thanks :tada:
