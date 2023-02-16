# Side Swipe

Side swipe is a transformation service.
Think "Launch Darkly", but instead of feature flags, Sideswipe allows for JSON transformations.

Here's a theoretical example of how an Elixir client might interact with Side Swipe:
```elixir

iex> %{ "some" => "data" } |> Client.intercept("some-transformation-point", "some-identifier")
%{"some" => %{"transformed" => "data"}}
```
Like launch-darkley, the client *may* opt to perform some level of local caching.
In the above, the client would send the following:

```
POST /transformations 
{
  "hook": "some-transformation-point",
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


Alternatively, the service could simply host the transformation definitions and the client could be responsible for transformation.
In that case, the request would look something like:

```
GET /transformations?hook="some-transformation-point"&identifier="some-identifier"
```
In the case in which there was a transformation that would be applied, Side Swipe would respond with the following:
```
Response Status Code: 200
Response Headers: (Revisit this)
Response Body:
{
  "template_language": "liquid",
  "template": "{% template %}"
}
```
In the case in which there was a transformation that would not be applied, Side Swipe would respond with the following:
```
Response Status Code: 204 (Revisit this)
Response Headers: (Revisit this)
```

The latter case has the opportunity to be more performant at the expense of complexity being moved to the client. The former case would only allow for a subset of caching (hence less performant) - that caching being whether or not a transormation was applicable given the parameters (not the transformation itself).