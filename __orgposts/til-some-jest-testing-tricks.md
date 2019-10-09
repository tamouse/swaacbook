
# Table of Contents

1.  [TIL: Some Jest testing tricks](#orgfdba777)
    1.  [TIL: using beforeAll and beforeEach in jest tests](#org102e541)
    2.  [TIL: you can call instance variables and functions on an Enzyme wrapper](#orgc491c29)


<a id="orgfdba777"></a>

# TIL: Some Jest testing tricks

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:26&gt;</span></span>
-   published date: 2018-01-19 22:12
-   keywords: jest, testing, react, instance, beforeEach, beforeAll, setup & teardown

Deeper learning after much pondering and RTFM for Jest


<a id="org102e541"></a>

## TIL: using beforeAll and beforeEach in jest tests

This has been bugging me for awhile. I have wanted to set up things in `beforeAll` and `beforeEach` functions, like I do in RSpec, but couldn't quite figure out how to get them in the `it` calls.

Turns out to be stupid simple. All you need to do is set the items on the `global` context, like so:

    beforeAll(()=>{
      global.TagsInstance = new Tags({
        item: item,
        item_type: "Job",
        data: data,
        mutate: noop
      })
    })

After the suite finishes, clear out the item:

    afterAll(()=>{
      global.TagsInstance = undefined
    })

I suppose that pollutes the global space, so one might want to do it in a namespace, and then clear that every time, too:

    beforeEach(()=>{
      global.beforeEach.actual = mount(
        <Tag item={item}/>
      )
    })
    
    afterEach(()=>{
      global.beforeEach = undefined
    })


<a id="orgc491c29"></a>

## TIL: you can call instance variables and functions on an Enzyme wrapper

Okay, this is very cool. I didn't know this would work BUT IT DOES!

This involves a few different things:

-   calling a method on a mounted instance of a component
-   putting an expect on a callback
-   interogating a mounted component's state

    it("can i call stuff directly?", ()=>{
      const actual = mount(<MyComponent />)
      actual.instance().setState({ boo: "boo"}, () => {
        expect(actual.instance().state.boo).toEqual("boo")
      })
    })

