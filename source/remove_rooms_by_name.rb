# example from Code Tester for Oracle tutorial
# http://www.quest.com/code-tester-for-oracle/product-demo/chap02.htm

# plsql.execute <<-SQL
# CREATE OR REPLACE PROCEDURE remove_rooms_by_name (
#   name_in IN rooms.name%TYPE)
# IS
# BEGIN
#   IF NAME_IN IS NULL
#   THEN
#     RAISE PROGRAM_ERROR;
#   END IF;
#
#   DELETE FROM rooms WHERE name LIKE name_in;
#
# END;
# SQL
