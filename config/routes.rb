EightyThousandHours::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts'
  
  resources :posts

  # for the rest of the profile routes
  match 'join'          => 'users#new', :as => :join
  resources :users, :path => "members"
  
  root  :to                             => 'info#index'
  match 'ethical-career'                => 'info#banker_vs_aid_worker'
  match 'what-you-can-do'               => 'info#what_you_can_do'
  match 'what-you-can-do/my-donations'  => 'info#my_donations'
  match 'what-you-can-do/my-career'     => 'info#my_career'
  match 'what-we-do'                    => 'info#what_we_do'
  match 'volunteer'                     => 'info#volunteer'
  match 'get-involved'                  => 'info#get_involved'
  match 'get-involved/volunteer'        => 'info#volunteer'
  match 'events'                        => 'info#events'
  match 'events/past-events'            => 'info#past_events'
  match 'events/orbis-stockpicking-challenge' => 'info#orbis_stockpicking_challenge'
  match 'career-research'               => 'info#career_research'
  match 'contact-us'                    => 'info#contact_us'
  match 'the-pledge'                    => 'info#the_pledge'
  match 'find-out-more'                 => 'info#find_out_more'
  match 'show-your-support'             => 'info#show_your_support'
  match 'blog'                          => 'info#blog'
  match 'press'                         => 'info#press'
  match 'application-faq'               => 'info#application_faq'
  match 'coming-soon'                   => 'info#coming_soon'
  match 'career-profiles'               => 'info#career_profiles'
  match 'meet-the-team'                 => 'info#meet_the_team'
  match 'banker-vs-aid-worker'          => 'info#banker_vs_aid_worker'
  match 'banker-vs-aid-worker/op-ed'    => 'info#op_ed'
  match 'banker-vs-aid-worker/q-and-a'  => 'info#q_and_a'
  match 'faq'                           => 'info#faq'
  match 'inspiring-others'              => 'info#inspiring_others'
  match 'giving-more'                   => 'info#giving_more'
end
