# An App To Stache Yo Self On Slack

Stache-Yo-Self is a Slack App with slash command and bot integration allowing users to type `/stache me` or `/stache @other_user` in any slack channel and receive a custom mustache'd profile picture of themselves back within seconds. Stache-Yo-Self leverages facial detection API Face Plus Plus to locate the perfect stache position and size to return a truly memorable experience, perfect to liven up any corporate meeting. Installation is easy!

![](http://g.recordit.co/VJNVtjb5zG.gif)


## What If My Profile Picture Doesn't Have My Face?

In the event that the internet has agreed you are faceless, you will be sent a consolation stache and words of encouragement for it will indeed be a sad day.

![](http://g.recordit.co/xgIwmiiemU.gif)

## Installation

Click the button below, log in to your Slack account and accept.

That's it!

<a href="https://slack.com/oauth/authorize?scope=commands&client_id=2329094327.23820365107"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>

Whenever you need a little stache in your Slack Life, simply type `/stache me` or `/stache @other_user` in any channel to have Stache-Yo-Self slap a mustache on your profile picture and send it back in all its mustachey glory. ****Mustache size varies based on smile size.


### New Users and Name Changes

If you are a new user or change your screen name on Slack, you will need to wait a day before others can stache you. Let's call it an adjustment period. You can still Stache Yo Self with reckless abandon.

### Privacy

Stache-Yo-Self does not reveal or distribute any identifying information to any third parties. Not even for money. Staches truly are priceless.

### Problems?

Log an Issue Here! Stache Yo Self is Open Source and maintained by Dan Winter.

### Features and Improvements To Be Completed Next

- Face Angle Adjustment for Staches
- Improved Testing (see below)
- Benchmark Alternate Servers For Increased Speed
- Additional Stache Choices
- Make Any Picture URL Stacheable
- In-House Facial Detection

#### Testing

After hours of scouring The Docs, StackOverflow and pestering everyone who would listen to me at Turing School of Software and Design, this is where we're at. When I look at the tests, I have a strong visceral reaction to it not being fully tested. What I'm trying to say is, I need your help. The lack of tests aren't for lack of trying, I simply don't know how to mock, stub or otherwise get these tests running without hitting outside services.

Contributors Welcome! Fork it, Branch it, PR it!

##### Testing Services

Using Typhoeus allows Stache Yo Self to use callbacks for longer API calls like facial detection and free up threads to handle other requests. When using VCR to test, it returns a Typhoeus object that has the body saved in JSON as key called body but in production, this is called response_body. Through many Stack Overflow posts and conversations, configuring VCR in rails_helper with hook_into :typhoeus or hook_into :webmock should work but have not been successful.

##### Testing Image Manipulation

Stache Yo Self leverages ImageMagick, Paperclip and AWS S3 to work with images. When saving a URI.parse(image_url) into Paperclip for use with AWS S3 in a testing development, I am able to manipulate where a file is saved with the default configuration options for paperclip but the URL that is returned on image.url contains a leading slash which makes me unable to find the image based on that path. Alternatively if I use image.path, it breaks production and ImageMagick is unable to find the image based on that path in order to manipulate it.


### LICENSE

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
