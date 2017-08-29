## GET /api/v1/slack/users
Check json contents.

### Example

#### Request
```
GET /api/v1/slack/users HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 147
Content-Type: application/json; charset=utf-8
ETag: W/"770250316027d8327759833ddcbb875c"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 6f6113ae-ffb6-4f0b-bc9a-03fa55e68fd9
X-Runtime: 0.010576
X-XSS-Protection: 1; mode=block

[
  {
    "slack_id": "U03XXXXXX",
    "name": "testuser",
    "real_name": "テスト ユーザー Test User (テス)",
    "profile_picture_url": "http://hoge.io/001.jpg"
  }
]
```
