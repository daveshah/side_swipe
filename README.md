# Side Swipe

Side swipe is a transformation service.
Think "Launch Darkly", but instead of feature flags, Sideswipe allows for JSON transformations.

Here's a theoretical example of how an Elixir client might interact with Side Swipe:
```elixir
%{"some" => %{"transformed" => "data"}} =

%{ "some" => "data" }
|> SideSwipeClient.intercept("some-transformation-point", "some-identifier")
```
Like launch-darkley, the client *may* opt to perform some level of local caching.
In the above, the client would send the following:

```
POST /transformations 
{
  "transformation_point": "some-transformation-point",
  "identifier": "some-identifier",
  "data": {
    "some": "data"
  }
}
```
In the case in which there was a transformation that would be applied, Side Swipe would respond with the following:
```
Response Status Code: 200
Response Headers: (Revisit this)
Response Body:
{
  "data": {
    "some": {
      "transformed": "data"
    }
  }
}
```
In the case in which there was a transformation that would not be applied, Side Swipe would respond with the following:
```
Response Status Code: 204 (Revisit this)
Response Headers: (Revisit this)
```



