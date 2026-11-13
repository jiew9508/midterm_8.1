# Sample articles are created only on the first run. Replace these with original writing.
if Article.count.zero?
  article1 = Article.create!(title: 'Getting Started With Ruby on Rails', topic: 'Programming', body: 'This is my first full stack blog built with Ruby on Rails. I learned how routes, controllers, models, and views work together to display pages and save articles. Next I want to build more features and test them in Cloud9.')
  article2 = Article.create!(title: 'What Cloud Computing Makes Possible', topic: 'Cloud', body: 'Cloud services let developers access servers and storage without buying all the hardware themselves. In this practice project, I used an online development environment to build and test a web application.')
  article3 = Article.create!(title: 'A Checklist Before I Commit Code', topic: 'Projects', body: 'Before I commit, I run the application, try the main buttons, and check that data saves correctly. Then I review the files and make a clear Git commit message.')
  article1.comments.create!(commenter: "Reader", body: "Great first post. Looking forward to more!")
end
