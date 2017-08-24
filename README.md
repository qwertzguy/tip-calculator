# Pre-work - *Tip Calculator*

**Tip Calculator** is a tip calculator application for iOS.

Submitted by: **Gaspard van Koningsveld**

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins): I think this is not useful as the natural app lifecycle can make that happen automatically in a more logical way (user didnt use app for a long time or user switched to many different apps or heavy apps).
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] User can select number of people to splitting the bill and view price per person.
- [x] The medium tip percentage is selected by default.
- [x] UI auto-resizes to screen size (auto-layout with constraints properly set).

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/SGP1TTz.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:**
- I like it so far. I'm surprised by how much animation utilities and helpers there is in the default SDK: very different from any other UI framework I used in the past. However, while being able to add reference to UI objects and actions in the code by dragging with the mouse is convenient, there is no easy way to refactor them: rename, change action argument list. Same thing with storyboards, I had some trouble to rename it.
- Outlets are reference to UI objects so you can call methods on them from your code. Actions are methods in your code that get called when some specified event happens to a UI element. They are a binding between your UI and your code.
- They are implemented in the xml of the Storyboard through the `connections` xml element. Sub-elements for each binding type exist, such as `action` and `outlet`. They contain attributes such as the `property` and `selector` for defining which field or method in the class it should bind to and `destination` for defining the id of the UIView the binding should be done on. InterfaceBuilder generates ids for the different views automatically so they can be used in the `destination` attribute. When the view of the Storyboard gets initalized through parsing the XML, it calls the `addTarget` method of the views to make the binding happen.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** You create a strong reference cycle in a closure by defining a class field with a closure as a value which itself references (uses) `self`. This is because when you use `self` inside the closure, the closure will transparently create a strong reference to `self` (instance of the defining class) and `self` has a strong reference to the closure because it is assigned to one of its fields.


## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
