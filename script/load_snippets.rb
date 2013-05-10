#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

Snippet.transaction do
  (1..50).each do |i|
    Snippet.create(lang: "Ruby", code: "puts #{i.to_s * 3}", title: i, user_id: User.find_by_name("dtan4").id)
  end
end
