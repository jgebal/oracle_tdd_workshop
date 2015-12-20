plsql.execute <<-SQL
CREATE OR REPLACE FUNCTION betwnstr (
   string_in   IN   VARCHAR2,
   start_in    IN   INTEGER,
   end_in      IN   INTEGER
) RETURN VARCHAR2 IS
BEGIN
   RETURN SUBSTR(string_in, start_in, end_in - start_in + 1);
END;
SQL

# example from utPLSQL project (http://utplsql.sourceforge.net/)
# plsql.execute <<-SQL
# CREATE OR REPLACE FUNCTION betwnstr (
#    string_in   IN   VARCHAR2,
#    start_in    IN   INTEGER,
#    end_in      IN   INTEGER
# )
#    RETURN VARCHAR2
# IS
#    l_start PLS_INTEGER := start_in;
# BEGIN
#    IF l_start = 0
#    THEN
#       l_start := 1;
#    END IF;
#
#    RETURN (SUBSTR (string_in, l_start, end_in - l_start + 1));
# END;
# SQL
