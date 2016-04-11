# An App To Stache Yo Self On Slack

Stache-Yo-Self is a Slack App with slash command and bot integration allowing users to type `/stache me` or `/stache @other_user` in any slack channel and receive a custom mustache'd profile picture of themselves back within seconds. Stache-Yo-Self leverages facial detection API Face Plus Plus to locate the perfect stache position and size to return a truly memorable experience, perfect to liven up any corporate meeting. Installation is easy!

## Installation

Click the button below, log in to your Slack account and accept.

That's it!

<a href="https://slack.com/oauth/authorize?scope=commands,bot&client_id=2329094327.23820365107"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>

Whenever you need a little stache in your Slack Life, simply type `/stache me` or `/stache @other_user` in any channel to have Stache-Yo-Self slap a mustache on your profile picture and send it back in all its mustachey glory. ****Mustache size varies based on smile size.


## What If My Profile Picture Doesn't Have My Face?

In the event that the internet has agreed you are faceless, you will be sent a consolation stache and words of encouragement for it will indeed be a sad day.

![](http://g.recordit.co/xgIwmiiemU.gif)


### Private Channels

Stache Yo Self, the bot, needs to be invited in to private channels in order for you to receive a stache.

### New Users and Name Changes

If you are a new user or change your screen name on Slack, you will need to wait a day before others can stache you. Let's call it an adjustment period. You can still Stache Yo Self with reckless abandon.

### Privacy

Stache-Yo-Self does not reveal or distribute any identifying information to any third parties. Not even for money. Staches truly are priceless.

### Problems?

Log an Issue Here! Stache Yo Self is Open Source and maintained by Dan Winter.

### Features and Improvements To Be Completed Next

- Improved Testing (see below)
- Face Angle Adjustment for Staches
- Benchmark Alternate Servers For Increased Speed
- Additional Stache Choices
- Optional Color-Of-Stache Argument
- In-House Facial Detection

#### Testing

When I first wrote this app, it was for a school project at Turing School of Software and Design. At the time, I ran into several issues that inhibited testing. While I love TDD, many facets of this app were spiked due to time constraints and it being my first Slack App, unsure how all the pieces worked together. I wrote tests for the pieces I knew how but there were unacceptable gaps. I haven't been satisfied with the level of testing so I've been slowly working away at it when I can find the time.

I had implemented multiple threads during the mustache request response process that let Stache Yo Self so that the initial request IO wasn't blocked. Testing multiple threads can be tricky and in restrospect, it may have been a better idea to have sent out another request to a custom API endpoint which launched the stacheing process but the more you program, the more you know. I also had some trouble appropriately stubbing, mocking and testing image manipulation with ImageMagick and how it was interacting with Paperclip and AWS. Since then, I've refactored my code to isolate methods better and make testing the multiple threads easier. I've also upped my mocking and stubbing game to avoid unnecessary API calls when unit testing.

Since using multi-threading runs the risk of tying up your threads for longer processes, I utilized SuckerPunch background workers to perform additional API calls and expensive tasks asynchronously and assign more workers to longer tasks. I also used the Typhoeus gem for making multiple parallel requests to update the end user while continuing the stacheing process. This gave me better confidence that my app wouldn't come to a grinding halt but it broke my tests. I had been using VCR to test my Faraday API calls. Unfortunately, even with the :typhoeus configuration hook in the VCR gem, it returns a Typhoeus object that responds to :response instead of :response_body like it does in production. Time constraints for the project meant I had to choose between the risk of tying up all my threads and having a full testing suite. At the time I opted for a smoothly running application but I wasn't satisfied. Recently, I forked the VCR gem, read through the source code and have successfully implemented a fix to return a Typhoeus object that behaves the same in testing as it does in production.

As I have time, I am building the testing suite back up to what my TDD-loving self finds acceptable.

Contributors Welcome! Fork it, Branch it, PR it!


### LICENSE

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
