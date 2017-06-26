# Onionfuzzer

Simple fuzzer web app that support:
* xss
* sqli
* blind sqli
* xpath injection
* rfi

## Usage

Execute : 

    $ ruby -Ilib ./bin/onion-fuzzer fuzz <yml file>

Output :

```
$ ruby -Ilib ./bin/onion-fuzzer fuzz ~/tmp/endpoints.yml 
 [high] (XSS) `name=<script>alert('XSS')</script>`, GET http://127.0.0.1/DVWA-master/vulnerabilities/xss_r/
 [high] (XSS) `name=<body onload=alert('XSS')>`, GET http://127.0.0.1/DVWA-master/vulnerabilities/xss_r/
 [high] (XSS) `name=<img src=x onError=alert('XSS')>`, GET http://127.0.0.1/DVWA-master/vulnerabilities/xss_r/
 [critical] (SQLI) `id='"`, GET http://127.0.0.1/DVWA-master/vulnerabilities/sqli/
 [critical] (SQLI) `id='"`, POST http://127.0.0.1/DVWA-master/vulnerabilities/sqli/
 [critical] (SQLI) `id=#`, POST http://127.0.0.1/DVWA-master/vulnerabilities/sqli/
 [high] (BSQLI) `id=' OR SLEEP(1)='`, GET http://127.0.0.1/DVWA-master/vulnerabilities/sqli_blind
 ...

```

All payloads are in `storage/payloads/` and fin pattern in `storage/patterns/`. Feel free to add more ([SecLists](https://github.com/danielmiessler/SecLists) for example)

## Endpoints template
```
http://127.0.0.1/DVWA-master/vulnerabilities/sqli/session-input.php:
  sqli_high:
    post:
      params:
        id:
        Submit: Submit
      cookies:
        PHPSESSID: <...>
        security: high
      types: [xss, sqli]

http://127.0.0.1/dvws/vulnerabilities/xpath/xpath.php:
  dvws_xpath:
    get:
      params:
        login: admin
        password:
        form: submit
      types: [xpath]
...
```

Still in progress

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

