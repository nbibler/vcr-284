This is a repo to explore a solution to https://github.com/vcr/vcr/issues/284.

This repo contains an example of generating dynamic response data based on
request URI values. This implementation is not officially supported by VCR and
uses private method hooks, so YMMV.

## With no previous recordings

```
Requesting for "testd6ece47420e08c9aef1503a637d336e9" callback value
Received "testd6ece47420e08c9aef1503a637d336e9" method.
.Requesting for 'testmethod' callback value
Received "testmethod" method.
.

Finished in 0.80622 seconds
2 examples, 0 failures
```

## With previous recordings

```
Requesting for 'testmethod' callback value
Received "testmethod" method.
.Requesting for "testd23db33bd815b243fcc9bb0702e2b8ac" callback value
Received "testd23db33bd815b243fcc9bb0702e2b8ac" method.
.

Finished in 0.03636 seconds
2 examples, 0 failures
```
