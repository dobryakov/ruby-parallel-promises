About
-----

This is an example of "parallel" tasks execution with Promises.

How to run example
------------------

    bundle
    ruby parallel.rb

And pay attention to the time marks (start and end).

Use cases
---------

* Send multiple HTTP requests.

This example was inspired by conversation with two employers who asked me to design a fault-tolerance HTTP-API to pack several "tasks" in one single request, pass them to legacy "original API" one by one, and get the results as one single pack too.

![Fault-tolerance API for pack multiple tasks in one job](/api-pack.png?raw=true "Fault-tolerance API for pack multiple tasks in one job")

This solution seemed too difficult for them, and I decided to create this simplified example based on single-instanced code.

