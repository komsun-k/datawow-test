# README

You can access the deployed application on <https://datawow.herokuapp.com/>

This project's stack is:
- Ruby on Rails
- Vue.js
- PostgreSQL

You have no need to setup locally, however I place the way to make it work locally as following title.

## How to make it work

1. After do git clone and setup the database. Then run a seeding-rake-task to import all categories from `categories.json`.

```bash
$ bin/rake data:seed_categories
```

2. Setup the frontend

```bash
$ yarn install
```

3. Now you would be able to start Rails server and webpack-dev-server on differnt Terminal windows.

```bash
$ bin/rails server
$ bin/webpack-dev-server
```

To run the test suite.

```bash
$ bundle exec rspec
```

I know I need to add more test cases for querying disired categories. But my limitation time. I must add them in real job.

## Note

The original seed data is `categories.json` on [s3](https://s3-ap-southeast-1.amazonaws.com/kiyo-development/test/categories.json).

IMPORTANT NOTE: The original `categories.json` file has a wrong data point, which is on `"id": 9603`. Its attribut value of `isLeaf` is `true`, but it is not a leaf node. I made a fix by changing its value to `false`, and save it as offline at location `/data/categories.json`.

The original data:

```json{6}
  // ...
  {
    "id": 9603,
    "name": "โดรน",
    "label": "โดรน",
    "isLeaf": true,
    "catPropertyModels": [],
    "rules": {},
    "firstLevelCatId": 3836,
    "lscSetId": 0,
    "variationCat": false,
    "active": true,
    "subcategories": [
      {
        "id": 14441,
        "name": "ใบพัดและอะไหล่โดรน",
        "label": "ใบพัดและอะไหล่โดรน",
        "isLeaf": true,
        "catPropertyModels": [],
        "rules": {},
        "firstLevelCatId": 3836,
        "lscSetId": 0,
        "active": true,
        "variationCat": false
      }
    ]
  }
  // ...
```

## Developer

| Field | Value                     |
|-------|---------------------------|
| Name  | Komsun Komoljindakul      |
| Email | komoljindakul@hotmail.com |
