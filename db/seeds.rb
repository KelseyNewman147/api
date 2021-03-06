def step(str)
  puts "==> #{str}"
end

def info(str)
  puts "--- #{str}"
end

CREDITS = YAML.load_file "config/credits.yml"

CREDITS.each do |attrs|
  name = attrs["name"]
  Credit.create_with(attrs).find_or_create_by!(name: name)
  step "created credit: #{name}"
end
info "(#{Credit.count} credits created)"

if Rails.env.development?
  Token.find_or_create_by!(description: "dev testing") do |t|
    t.token = "devtoken"
  end
  step "created token for 'dev testing'"
end

unknown_user = User.find_or_create_by!(email: "unknown") do |u|
  u.first_name = "unknown"
  u.last_name = "unknown"
  u.picture = "http://lorempixel.com/output/people-q-c-100-100-2.jpg"
end
step "created unknown user"

random_user = User.find_or_create_by!(email: "random@user.com") do |u|
  u.first_name = "random"
  u.last_name = "random"
  u.picture = "http://lorempixel.com/output/people-q-c-100-100-1.jpg"
end
step "created random user '#{random_user.email}'"

e = Event.create!(category: CREDITS.sample["name"], user_id: unknown_user.id, info: { source: "db:seed" })
unknown_user.cred_transactions.create(event_id: e.id, delta: 100)
step "created a #{e.category} event for unknown user"

e = Event.create! category: CREDITS.sample["name"], user_id: random_user.id, info: { source: "db:seed" }
random_user.cred_transactions.create(event_id: e.id, delta: 20)
step "created a #{e.category} event for random user"

info "unknown user credibility: #{unknown_user.credibility}"
info "random user credibility: #{random_user.credibility}"
