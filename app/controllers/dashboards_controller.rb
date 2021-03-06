require 'pry'

class DashboardsController < ApplicationController

  get '/dashboard' do
    haml :'dashboard/index'
  end

  get '/dashboard/encrypt' do
    haml :'dashboard/encrypt'
  end

  get '/dashboard/decrypt' do
    haml :'dashboard/decrypt'
  end

  get '/dashboard/s3_decrypt' do
    haml :'dashboard/s3_decrypt'
  end

  post '/encrypt' do
    response = RubyCryptoManager.new(command: 'encrypt_to_s3', options: params).process    
    haml :'dashboard/s3_response', :locals => {:response => response}
  end

  post '/decrypt' do
    response = RubyCryptoManager.new(command: 'decrypt_to_stdout', options: params).process
    haml :'dashboard/s3_response', :locals => {:response => response}
  end

  post '/s3_decrypt' do
    RubyCryptoManager.new(command: 'decrypt_to_s3', options: params).process
    haml :'dashboard/s3_response'
  end
end
