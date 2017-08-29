## GET /api/v1/messages
Response success.

### Example

#### Request
```
GET /api/v1/messages HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 270
Content-Type: application/json; charset=utf-8
ETag: W/"9f1a59a2b36ad1b84ee20f98e47dae95"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 2b8c929e-a099-4326-ab94-546f95ece14d
X-Runtime: 0.070432
X-XSS-Protection: 1; mode=block

[
  {
    "id": 25,
    "user_id": 25,
    "message": "Slack User 001: Message 00001",
    "due_at": "2017-08-12T18:47:29.000+09:00",
    "require_confirm": true,
    "created_at": "2017-08-29T13:30:50.000+09:00",
    "updated_at": "2017-08-29T13:30:50.000+09:00",
    "report": {
      "answered_count": 0,
      "mentioned_count": 0
    }
  }
]
```

## GET /api/v1/messages/:message_id
Response success.

### Example

#### Request
```
GET /api/v1/messages/26 HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 441
Content-Type: application/json; charset=utf-8
ETag: W/"46c382972de86466eb3b9bdf092d13ac"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e105611d-34d3-42c0-8112-b1813a643d8c
X-Runtime: 0.035190
X-XSS-Protection: 1; mode=block

{
  "id": 26,
  "user_id": 26,
  "message": "Slack User 001: Message 00001",
  "due_at": "2017-08-12T18:47:29.000+09:00",
  "require_confirm": true,
  "created_at": "2017-08-29T13:30:50.000+09:00",
  "updated_at": "2017-08-29T13:30:50.000+09:00",
  "report": {
    "answers": [
      {
        "text": "text",
        "count": 1,
        "percentage": 100.0
      }
    ],
    "mentioned": [
      {
        "name": "USER0",
        "profile_picture_url": "http://hoge/user0.jpg",
        "answers": [
          {
            "answer": "text",
            "answered_date": "2017-08-29T13:30:50.000+09:00"
          }
        ]
      }
    ]
  }
}
```

## POST /api/v1/messages
Resposne created.

### Example

#### Request
```
POST /api/v1/messages HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 231
Content-Type: application/x-www-form-urlencoded
Host: www.example.com

message=hoge&require_confirm=0&due_at=2017-08-15+10%3A00%3A00&button_type=single&message_buttons[][text]=button01&mentions[][slack_id]=UHOGEHOGE&mentions[][name]=fuga&mentions[][profile_picture_url]=http%3A%2F%2Fhoge.com%2Ffuga.jpg
```

#### Response
```
HTTP/1.1 201
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 517
Content-Type: application/json; charset=utf-8
ETag: W/"0a12d63e465153086f7adce48fd4cc44"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c63762bf-40d6-42ba-969b-6146fd7fccd3
X-Runtime: 0.025759
X-XSS-Protection: 1; mode=block

{
  "id": null,
  "user_id": 1,
  "message": "hoge",
  "due_at": "2017-08-15T10:00:00.000+09:00",
  "require_confirm": false,
  "created_at": null,
  "updated_at": null,
  "callback_id": "c86613e2111d09a1",
  "button_type": "single",
  "message_buttons": [
    {
      "id": null,
      "message_id": null,
      "name": "3e31c8f6c339b393",
      "text": "button01",
      "created_at": null,
      "updated_at": null
    }
  ],
  "mentions": [
    {
      "id": null,
      "message_id": null,
      "slack_id": "UHOGEHOGE",
      "created_at": null,
      "updated_at": null,
      "name": "fuga",
      "profile_picture_url": "http://hoge.com/fuga.jpg",
      "channel": null,
      "ts": null
    }
  ]
}
```
