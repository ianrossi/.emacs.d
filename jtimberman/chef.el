(defun chef-service ()
  "Insert a Chef Service Resource"
  (interactive)
  (insert "service \"\" do\n"
          "  supports :status => true, :restart => true\n"
          "  action [:enable, :start]\n"
          "end\n"))

(defun chef-template ()
  "Insert a Chef Template Resource"
  (interactive)
  (insert "template \"\" do\n"
          "  source \"\"\n"
          "  mode 0644\n"
          "  owner 'root'\n"
          "  group 'root'\n"
          "end\n"))

(defun chef-remotefile ()
  "Insert a Chef Remote File Resource"
  (interactive)
  (insert "remote_file \"\" do\n"
          "  source \"\"\n"
          "  mode 0644\n"
          "  owner 'root'\n"
          "  group 'root'\n"
          "end\n"))

(defun chef-ruby-block ()
  "Insert a Chef Ruby Block Resource"
  (interactive)
  (insert "ruby_block \"\" do\n"
          "  block do\n\n  "
          "  end\n"
          "end\n"))
