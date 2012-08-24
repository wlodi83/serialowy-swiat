# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user = User.create [{
:email => 'lukasz.wlodarczyk@yahoo.com', 
:password => 'password',
:password_confirmation => 'password',
:admin => true
}]
Category.create [{:name => 'Seriale'},
{:name => 'Filmy'},
{:name => 'TV'},
{:name => 'Dokumenty TV'},
{:name => 'Dla Dzieci'},
{:name => 'Teledyski'},
{:name => 'Najnowsze', :parent_id => 1},
{:name => 'Polskie', :parent_id => 1},
{:name => 'Zagraniczne', :parent_id => 1},
{:name => 'Najnowsze', :parent_id => 2},
{:name => 'Polskie', :parent_id => 2},
{:name => 'Zagraniczne', :parent_id => 2},
{:name => 'Najnowsze', :parent_id => 3},
{:name => 'Polskie', :parent_id => 3},
{:name => 'Zagraniczne', :parent_id => 3},
{:name => 'Dramaty', :parent_id => 3},
{:name => 'Sensacyjne', :parent_id => 3},
{:name => 'Komedie', :parent_id => 3},
{:name => 'Najnowsze', :parent_id => 4},
{:name => 'Polskie', :parent_id => 4},
{:name => 'Zagraniczne', :parent_id => 4},
{:name => 'Najnowsze', :parent_id => 5},
{:name => 'Polskie', :parent_id => 5},
{:name => 'Zagraniczne', :parent_id => 5},
{:name => 'Najnowsze', :parent_id => 6},
{:name => 'Polskie', :parent_id => 6},
{:name => 'Zagraniczne', :parent_id => 6}]
