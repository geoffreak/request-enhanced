Request Enhanced
================

Request Enhanced is a Node.js library that functions as a layer on top of the [request](https://github.com/mikeal/request) library to further abstract and simplify web requests. No worries about handling simple errors or retries, pooling requests, dealing with the complexity of writing to a file, or even manually searching the fetched content. Just fetch and done.


Installing
----------

```
npm install request-enhanced
```


Basic Usage
-----------

To perform a simple GET request, you can use the following code:

```javascript
var re = require('request-enhanced');
re.get('http://www.example.com', function(error, data){
  console.log('Fetched:', data);
});
```


What if you don't want the result in memory and would rather pipe it to a file? No problem!

```javascript
re.get('http://www.example.com', '/path/to/resulting/file', function(error, filename){
  console.log('Saved content to:', filename);
});
```


New Features
------------

In addition to the awesome features that request offers, you get the following bonus features with request-enhanced

* **Greater File Saving Simplicity** - No more worrying about odd edge cases or strange syntax when downloading to files. Directories are also automatically created along the specified file path as necessary.

* **Request Pooling** - All requests are pooled to prevent EMFILE errors from too many simultaneous requests.

* **Request Prioritizing** - Requests can be given a priority so that higher priority requests can execute first. 

* **Easy Regex Searching of Results** - With regex queries, searching the resulting textual data becomes extremely simple.



Regex Queries
-------------
Regex queries are a much simpler way to deal with searching in the returned content. When a regex query object is present in a call to the `get` function, the fetched data will be automatically parsed.

#### Basic Regex Query
Here is a very simple regex query:
```javascript
{
  query: {
    regex: /My query: "(.*?)"/i
    results: 1
  }
}
```
What this means is that the fetched data will be searched for the regex

**Remember!** The `.` character in JavaScript flavored regular expressions *doesn't* match line breaks by default. You will need to set the multiline flag `m` in your RegExp object, or use `multiline: true` for a string regular expression

Documentation
-------------

### The `get` Function

The `get` function actually has a bunch of optional parameters to achieve additional functionality. A detailed description of each of the parameters is below.

```
get ( options, [filename or regex], [priority], callback )
```

#### options
The options parameter behavior is nearly identical to request's options paramter. You can pass a string URL of the target or any of [request's parameters](https://github.com/mikeal/request#requestoptions-callback) in an options object with the following additional options:
* `maxAttempts` - The maximum number of attempts to retry the request, defaults to `10`
* `retryDelay` - The delay in milliseconds before trying again after a recoverable failure, defaults to `5000`
* `defaultValue` - The default value to assign to regex queries that find no data, defaults to `''`

The following options already existing in request now have default values:
* `timeout` - Now defaults to `10000`
* `pool` - Now defaults to `{maxSockets: Infinity}`

#### filename
The filename is an optional string representing a location on disk where the results of the GET request should be written to. Any directories in the path not currently existing will be created automatically.

#### regex
To perform regular expression searches on the returned data, an optional regex query object can be provided. Regex queries are explained in the "Regex Queries" section above.

#### priority
The priority is an optional number representing the request's priority. Requests with a lesser value will be performed prior to those with a higher valued priority. Requests with the same priority will be performed in a [FIFO order](http://en.wikipedia.org/wiki/FIFO). If not specified, a request is given the default priority of `0`.

#### callback
The callback function will be called on success or error due to unrecoverable error or reaching the maximum retries. The following parameters will be passed back to this function in the following order:
* `error` - This will either be an error object if there was an error, or `null` if there was not. The error object may have a `code` paramter for an HTTP status code if the error was HTTP related.
* `data` - If a filename was specified in the call, a string filename will be returned of the newly saved file on disk. If a filename was not specified in the call, the string data returned from the GET request will be returned.
* `results` - If regex queries were specified in the call and a filename was not, the results of the queries running on the `data` will be returned in this object
