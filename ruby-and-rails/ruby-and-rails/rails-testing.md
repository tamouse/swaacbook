# Rails Testing

### Capybara

#### When Capybara can't find something in a modal: Scrolling the modal in Capybara

This is a problem where we have a modal that is long \(going below where the parent window bottom is\) and we need to get the "Submit" button at the end of the modal. The following executes the script on the page so the Submit button moves into view.

```text
page.execute_script "window.scrollBy(0,10000)"
```

I believe the issue is that the capybara driver does not "see" anything that might be below the parent window bottom if the child is not scrolled into view.

This isn't the complete solution, just what worked for us at the time.



