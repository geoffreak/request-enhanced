Request Enhanced
================

A layer on top of the request library to further abstract and simplify web requests. No worries about handling simple errors or retries, dealing with the complexity of writing to a file, or even manually searching the fetched content. Just fetch and done.


Installing
----------

    npm install request-enhanced


Using
-----

To perform a simple GET request, you can use the following code:

```javascript
    var re = require('request');
    re.get('http://www.example.com', function(error, html){
      console.log('Fetched:', html);
    });
```