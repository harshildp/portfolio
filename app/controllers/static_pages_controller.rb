class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def projects
    @projects = [
      {
        'name' => 'Fuzzytime Pip Module',
        'desc' => 'A published pip module for Python which I wrote out of the necessity for fuzzy timestamps in many of my projects.' +
        ' This module converts a datetime object, time object, date object, epoch int or date/time string into a fuzzy timestamp such as "just now", "about 5 minutes ago" or "about an hour ago".' + 
        ' This module also works for future dates giving an output such as "in five minutes". The module converts any input into a datetime, subtracts the current datetime and then runs a binary search algorithm with the remainder to figure out which output message to piece together.' +
        ' The choice of a binary search algorithm was made to speed up the overall process. Although miniscule the difference is felt when a large number of consecutive operations are conducted.' +
        ' The module is pip installable by anyone by running "pip install fuzzytime" in the command line.',
        'git' => 'https://github.com/harshildp/fuzzytime',
        'tech' => 'Python and twine.'
      },
      {
        'name' => 'Reddit Clone',
        'desc' => 'One of the earliest comprehensive projects I completed was a Reddit clone for a hackathon at Coding Dojo. Placed into groups of three, the project was completed over the course of one weekend. ' +
        'Having just learnt our first framework, Flask, we took the opportunity to go above and beyond the base requirements and explored many different ideas. Most notably it was our first time working with bootstrap and using true creative freedom rather than focussing only on functionality. ' +
        ' We also researched recursion in order to build nested comments and emulate one of the hallmarks of Reddit. Our hard work earned us first place in the hackathon and the project remains one of the most interesting projects I have worked on as well as one I am most proud of.',
        'tech' => 'Python with Flask, HTML, CSS, Twitter Bootstrap, JavaScript with jQuery and a MySQL database.',
        'git' => 'https://github.com/harshildp/hackathon_reddit_clone',
        'demo' => 'https://www.youtube.com/watch?v=b-g-IpZrCQY'
      }
    ]
  end

  def contact
  end

  def mail
    reg = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    session[:name] = params[:name]
    session[:email] = params[:email]
    session[:message] = params[:message]
    @data = {
      name: params[:name],
      email: params[:email],
      message: params[:message]
    }
    p 'data', @data
    if @data[:name].length < 3
      flash[:name] = 'Name cannot be less than 3 characters.'
    end
    if not @data[:email].match(reg) and @data[:email].length <= 3
      flash[:email] = 'Email is invalid. (ex. contact@harshilpatel.me)'
    end
    if @data[:message].length < 10
      flash[:message] = 'Message cannot be less than 10 characters.'
    end
    if not flash[:name] and not flash[:email] and not flash[:message]
      UserMailer.contact_email(@data).deliver_now
      reset_session
      flash[:success] = 'Message successfully sent! :)'
    end
    redirect_to contact_path
  end
end
