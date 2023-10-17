##### Docstrings
Please use the google docstring when developing in python. Try to use it for each class that you write. Here's a definition of the format: https://google.github.io/styleguide/pyguide.html#s3.8.1-comments-in-doc-strings 
Example:
```python
"""
    Connects to the next available port.

    Args:
      minimum: A port value greater or equal to 1024.

    Returns:
      The new minimum port.

    Raises:
      ConnectionError: If no available port is found.
"""
```
##### Snake case for everything except classes
Please use snake_case for every attribute, file name, var name, function name, etc. Only use CamelCase for classes. Example:

```python
class MyClass:
  attribute_1: str
  attribute_2: str
  def my_function(my_input: str) -> str:
    ...
```

##### Use typing
In order to make the code transparent, please always use typing when you are coding. Example:

```python
def my_func(attribute_1: MyType) -> ReturnType:
  ...
```