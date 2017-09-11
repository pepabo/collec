## GET /api/v1/messages
Response success.

### Example

#### Request
```
GET /api/v1/messages?page=1 HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 6900
Content-Type: application/json; charset=utf-8
ETag: W/"05d0c6d47d987f9e4d177004dc7cfa7b"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 7e8d0470-b0f8-4fa5-b158-39b5eb118868
X-Runtime: 0.078659
X-XSS-Protection: 1; mode=block

{
  "messages": [
    {
      "id": 7610,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7611,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7612,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7613,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7614,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7615,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7616,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7617,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7618,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7619,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7620,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7621,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7622,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7623,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7624,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7625,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7626,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7627,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7628,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7629,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7630,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7631,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7632,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7633,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    },
    {
      "id": 7634,
      "user_id": 2417,
      "message": "Slack User 001: Message 00001",
      "due_at": "2017-08-12T18:47:29.000+09:00",
      "require_confirm": true,
      "created_at": "2017-09-08T00:24:00.000+09:00",
      "updated_at": "2017-09-08T00:24:00.000+09:00",
      "report": {
        "answered_count": 0,
        "mentioned_count": 0
      }
    }
  ],
  "paging": {
    "previous": null,
    "next": "/api/v1/messages/?page=2"
  }
}
```

## GET /api/v1/messages/:message_id
Response success.

### Example

#### Request
```
GET /api/v1/messages/7662 HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 447
Content-Type: application/json; charset=utf-8
ETag: W/"3153828d58321d3e137b0e0c04dcb9d9"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 75da6cb0-5fbc-40ec-b749-316bf2937350
X-Runtime: 0.025317
X-XSS-Protection: 1; mode=block

{
  "id": 7662,
  "user_id": 2419,
  "message": "Slack User 001: Message 00001",
  "due_at": "2017-08-12T18:47:29.000+09:00",
  "require_confirm": true,
  "created_at": "2017-09-08T00:24:00.000+09:00",
  "updated_at": "2017-09-08T00:24:00.000+09:00",
  "report": {
    "answers": [
      {
        "text": "text1",
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
            "answer": "text1",
            "answered_date": "2017-09-08T00:24:00.000+09:00"
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
Content-Length: 695
Content-Type: application/json; charset=utf-8
ETag: W/"320561fae1b6efcc67acdb9db396780d"
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: e37adb8e-c0de-4b04-8464-08fd2ab27d4e
X-Runtime: 0.028071
X-XSS-Protection: 1; mode=block

{
  "id": 7663,
  "user_id": 2420,
  "message": "hoge",
  "due_at": "2017-08-15T10:00:00.000+09:00",
  "require_confirm": false,
  "created_at": "2017-09-08T00:24:01.000+09:00",
  "updated_at": "2017-09-08T00:24:01.000+09:00",
  "callback_id": "2b63ec2bd93a58c3",
  "button_type": "single",
  "message_buttons": [
    {
      "id": 968,
      "message_id": 7663,
      "name": "7b0c5208356c0e22",
      "text": "button01",
      "created_at": "2017-09-08T00:24:01.000+09:00",
      "updated_at": "2017-09-08T00:24:01.000+09:00"
    }
  ],
  "mentions": [
    {
      "id": 1079,
      "message_id": 7663,
      "slack_id": "UHOGEHOGE",
      "created_at": "2017-09-08T00:24:01.000+09:00",
      "updated_at": "2017-09-08T00:24:01.000+09:00",
      "name": "fuga",
      "profile_picture_url": "http://hoge.com/fuga.jpg",
      "channel": null,
      "ts": null,
      "text": "hoge"
    }
  ]
}
```
