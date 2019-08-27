# TIL: don't put subcomponents inside a React component

Post date: 2019-08-27

TIL: Don't define react components in another react component -- they'll get unmounted and remounted every time.

Using the const with fat-arrow form lets you put the subcomponents after the main component to reduce clutter.

## Bad:

```jsx
const MainComp = props => {

  function SubComp1(props) {
    return (
      <div>
        I do the {props.dance}
      </div>
    )
  }

  return (
    <div>
      <h3>What?</h3>
      <SubComp1 dance="Twist" />
    </div
  )
}
```

In the above `SubComp1` is remounted with every re-render.

## Good

```jsx
function SubComp1(props) {
  return (
    <div>
      I do the {props.dance}
    </div>
  )
}

const MainComp = props => {

  return (
    <div>
      <h3>What?</h3>
      <SubComp1 dance="Twist" />
    </div
  )
}
```

## Better

```jsx
const MainComp = props => {

  return (
    <div>
      <h3>What?</h3>
      <SubComp1 dance="Twist" />
    </div
  )
}

const SubComp1 = ({ dance }) => (
  <div>
    I do the {dance}
  </div>
)
```

This leaves the `MainComp` as the first function in the file. If you're going to use the "Good" form, you might be better moving `SubComp1` to another file and import it.

Keywords: JavaScript, React, subcomponents

