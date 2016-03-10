An App To Stache Yo Self On Slack

Stache-Yo-Self is a Slack App with slash command and bot integration allowing users to type '/stache_me' in any slack channel and receive a custom mustache'd profile picture of themselves back within seconds. Stache-Yo-Self leverages facial detection API Face Plus Plus to locate the perfect stache position and size to return a truly memorable experience, perfect to liven up any corporate meeting. Installation is easy!

![](http://g.recordit.co/VJNVtjb5zG.gif)


What If My Profile Picture Doesn't Have My Face?

In the event that the internet has agreed you are faceless, you will be sent a consolation stache and words of encouragement for it will indeed be a sad day.

![](http://g.recordit.co/xgIwmiiemU.gif)

Installation

Click the button below, log in to your Slack account and accept.

That's it!

<a href="https://slack.com/oauth/authorize?scope=commands&client_id=2329094327.23820365107"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>

Whenever you need a little stache in your Slack Life, simply type '/stache_me' in any channel to have Stache-Yo-Self slap a mustache on your profile picture and send it back in all its mustachey glory. ****Mustache size varies based on smile size.



New Users and Name Changes

If you are a new user or change your screen name on Slack, you will need to wait a day before taking on all that Stache Yo Self has to offer. Good things come to those who wait.

Privacy

Stache-Yo-Self does not reveal or distribute any identifying information to any third parties. Not even for money. Staches truly are priceless.

Problems?

Log an Issue Here! Stache Yo Self is Open Source and maintained by Dan Winter.

Features and Improvements To Be Completed Next

- Face Angle Adjustment for Staches
- Improved Testing (see below)
- Benchmark Alternate Servers For Increased Speed
- Additional Stache Choices
- Make Any Picture URL Stacheable
- In-House Facial Detection

Testing

Testing this app has been difficult and I welcome contributors to assist.

Testing Services

Using Typhoeus allows Stache Yo Self to use callbacks for longer API calls like facial detection and free up threads to handle other requests. When using VCR to test, it returns a Typhoeus object that has the body saved in JSON as key called body but in production, this is called response_body. Through many Stack Overflow posts and conversations, configuring VCR in rails_helper with hook_into :typhoeus or hook_into :webmock should work but have not been successful.

Testing Image Manipulation

Stache Yo Self leverages ImageMagick, Paperclip and AWS S3 to work with images. When saving a URI.parse(image_url) into Paperclip for use with AWS S3 in a testing development, I am able to manipulate where a file is saved with the default configuration options for paperclip but the URL that is returned on image.url contains a leading slash which makes me unable to find the image based on that path. Alternatively if I use image.path, it breaks production and ImageMagick is unable to find the image based on that path in order to manipulate it.
