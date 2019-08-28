
# Table of Contents

1.  [Postgresql Timestamp Accuracy and Precision](#org042ea0a)
    1.  [RTFM](#org1ed6db7)
    2.  [FactoryGirl insert](#org8267ec1)
    3.  [Create multiple records](#orga3ab3bb)
    4.  [SQL Insert with date formatting](#org9d5656b)
        1.  [Forgetting the milliseconds: Ooops](#orgc3f0d90)
    5.  [SQL `now()` function](#orge6f0fb7)
    6.  [Single insert statement, multiple values with `now()`](#orge94663c)
    7.  [Conclusion](#org8414083)


<a id="org042ea0a"></a>

# Postgresql Timestamp Accuracy and Precision

-   published date: 2017-05-09 21:31
-   keywords: postgresql, databases, timestamps, test

Today at work, a question came up whether one could count on the last inserted item in a table to have the most recent value for the `created_at` timestamp, so I went looking.


<a id="org1ed6db7"></a>

## RTFM

The [postgresql documentation](https://www.postgresql.org/docs/9.6/static/index.html) for [Date / Time Types](https://www.postgresql.org/docs/9.6/static/datatype-datetime.html) shows the resolution as 14 digits and 1 microsecond.


<a id="org8267ec1"></a>

## FactoryGirl insert

I ran a small experiment where I first used `FactoryGirl` to insert 50 records. These showed only increasing timestamps showing there's enough resolution at a microsecond to distinguish insertion order accurately building and inserting objects with FG.

    select id,created_at from posts;
     id  |         created_at
    -----+----------------------------
     453 | 2017-05-10 03:24:20.065175
     454 | 2017-05-10 03:24:20.074039
     455 | 2017-05-10 03:24:20.077969
     456 | 2017-05-10 03:24:20.08049


<a id="orga3ab3bb"></a>

## Create multiple records

Next I tried it by creating an array of new values and passing it to the `.create` method of the Model. This also showed plenty of resolution where none of them would be considdred a "tie" when ordering.

     id  |         created_at
    -----+----------------------------
     553 | 2017-05-10 03:26:22.415659
     554 | 2017-05-10 03:26:22.432941
     555 | 2017-05-10 03:26:22.436157
     556 | 2017-05-10 03:26:22.437815
     557 | 2017-05-10 03:26:22.439465


<a id="org9d5656b"></a>

## SQL Insert with date formatting

One of the things Rails is poor at is mass uploading. In the past I've used techniques to get around this. So giving that a go, I built a set of insert statements that used rails's `DateTime.now` to generate the timestamp.

    data = (1..100).map do |_|
      OpenStruct.new(
        content: Faker::Lorem.sentence,
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
    end

Then made that into an SQL statement.

    insert = data.map do |x|
      "insert into posts (content, created_at, updated_at) " +
      "values ('#{x.content}', '#{x.created_at.strftime("%FT%T.%6N%Z")}', " +
      "'#{x.updated_at.strftime("%FT%T.%6N%Z")}' ); "
    end.join();

This gave the same result of increasing timestamps.

    select id,created_at from posts;
     id  |         created_at
    -----+----------------------------
     603 | 2017-05-09 22:29:35.038286
     604 | 2017-05-09 22:29:35.038382
     605 | 2017-05-09 22:29:35.038421
     606 | 2017-05-09 22:29:35.038455
     607 | 2017-05-09 22:29:35.038484


<a id="orgc3f0d90"></a>

### Forgetting the milliseconds: Ooops

Note that if the milliseconds are not included in the `strftime` method above, then it is quite possible to insert timestamps that look the same.

    insert = data.map do |x|
      "insert into posts (content, created_at, updated_at) " +
      "values ('#{x.content}', '#{x.created_at.strftime("%FT%T%Z")}', " +
      "'#{x.updated_at.strftime("%FT%T%Z")}' ); "
    end.join();

Oops:

    select id,created_at from posts;
     id  |     created_at
    -----+---------------------
     703 | 2017-05-09 22:42:57
     704 | 2017-05-09 22:42:57
     705 | 2017-05-09 22:42:57
     706 | 2017-05-09 22:42:57


<a id="orge6f0fb7"></a>

## SQL `now()` function

Next, I build an SQL query using the `now()` method for each new record.

    select id,created_at from posts;
     id  |         created_at
    -----+----------------------------
     653 | 2017-05-10 03:36:42.252631
     654 | 2017-05-10 03:36:42.252631
     655 | 2017-05-10 03:36:42.252631
     656 | 2017-05-10 03:36:42.252631
     657 | 2017-05-10 03:36:42.252631

Here we can see that every value inserted got the same timestamp. Conclusion that Postgresql calculates `now()` once in compiling the insert statement.


<a id="orge94663c"></a>

## Single insert statement, multiple values with `now()`

Final check, using a single `insert into` statement with multiple values.

    insert into posts (content, created_at, updated_at) values
    ('Aut exercitationem harum molestiae.', now(), now()),
    ('Aliquid sit et distinctio quidem minima ut.', now(), now()),
    ('Officiis dolores cupiditate aut sit.', now(), now());

(only for 100 items.)

This gives the same result as the previous, as expected.

    select id,created_at from posts;
     id  |         created_at
    -----+----------------------------
     353 | 2017-05-10 03:04:59.684801
     354 | 2017-05-10 03:04:59.684801
     355 | 2017-05-10 03:04:59.684801
     356 | 2017-05-10 03:04:59.684801
     357 | 2017-05-10 03:04:59.684801


<a id="org8414083"></a>

## Conclusion

So it seems as though one might not be able to count on inserted values having an increasing `created_at` value, but this won't come up very often in a Rails app unless you're doing mass-inserts like the above.

