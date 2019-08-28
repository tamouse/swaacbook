
# Table of Contents

1.  [Link: How to Access Production Data in Rails Migrations](#orgdfe9211):rails:migrations:data:

\#+COMMENT -**- time-stamp-line-limit: 12; time-stamp-count: 2 -**-


<a id="orgdfe9211"></a>

# Link: [How to Access Production Data in Rails Migrations](https://www.gregnavis.com/articles/how-to-access-production-data-in-rails-migrations.html)     :rails:migrations:data:

-   last update: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-04-05 Fri 00:56&gt;</span></span>
-   keywords: rails, migrations, data
-   capture date: <span class="timestamp-wrapper"><span class="timestamp">[2019-04-05 Fri 00:35]</span></span>

This article represents standard practice when you have to access actual data in the database (i.e. production) when running a migration. The example they use of adding a slug is pretty straight-forward. Beware, though, when modifying a table that has a huge number of records as this will effectively lock out the table while the migration is running. If you do go this route, better to schedule the down time.

Of particular importance is to create the ActiveRecord models in the migration for the tables being modified. Do **not** use the actual models to avoid callbacks, validations, and the like.

