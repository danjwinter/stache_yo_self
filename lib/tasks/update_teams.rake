desc "Update user names and ids on configured teams"
task :update_teams => :environment do
  teams = SlackTeam.all
  teams.each do |team|
    SlackService.save_users(team)
    puts "Updated team #{team.team_name}"
  end
end
