# Room Monitor

Room monitor system with "motion" and USB camera.

## Prepare
1. Install `motion` and `ruby`.
1. Install ruby gems
   ```
   bundle install
   ```
1. Prepare secret key for Dropbox and copy to `secret/dropbox`

## How to use
1. Create cron job to push generated file to cloud.
   ```
   MAILTO=""
   
   */20 *	* * *	<USER> /usr/bin/ruby <PATH_TO_ROOM_MONITOR>/push_to_dropbox.rb
   ```
1. Start `motion`
   ```
   ./start_motion.sh
   ```
