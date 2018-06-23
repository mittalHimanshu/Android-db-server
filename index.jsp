<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>        
<%        
    String choice = request.getParameter("choice");
        if(choice.equals("1")){
            try{
            Class.forName("com.mysql.jdbc.Driver");
            java.sql.Connection c;
            c = DriverManager.getConnection("jdbc:mysql://sql7.freemysqlhosting.net:3306/sql7236208", "sql7236208", "R5kkHabXDs");
            Statement s = c.createStatement();         
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String sql = "SELECT * from androidServer where username = '"+username+"' ";
            ResultSet rs = s.executeQuery(sql);
            if(username.equals("") || name.equals("") || password.equals("") || email.equals("") || phone.equals("")){
                response.getWriter().append("emptyfields");
            }
            else if(rs.next()){
                response.getWriter().append("false");
                }
            else if(!email.matches("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}")){
                response.getWriter().append("emailerror");
            }
            else if(!phone.matches("(7|8|9)\\d{9}")){
                response.getWriter().append("phoneerror");
            }
            else{              
                PreparedStatement ps = c.prepareStatement("insert into androidServer values (?, ?, ?, ?, ?)");
                ps.setString(1, username);
                ps.setString(2, name);
                ps.setString(3, password);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.executeUpdate();
                response.getWriter().append("true");            
            }
            rs.close();
        }
        catch(Exception e){} 
        }
        else if(choice.equals("2")){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection c;
                c = DriverManager.getConnection("jdbc:mysql://sql7.freemysqlhosting.net:3306/sql7236208", "sql7236208", "R5kkHabXDs");
                Statement s = c.createStatement();    
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String sql = "SELECT * from androidServer where username = '"+username+"' ";
                ResultSet rs = s.executeQuery(sql);
                if(rs.next()){
                    String pass = rs.getString("password");
                    if(pass.equals(password)){
                        response.getWriter().append("passmatch");
                    }
                    else{
                        response.getWriter().append("wrongpass");
                    }
                }
                else{
                    response.getWriter().append("nouser");
                }
                rs.close();
            }
            catch(Exception e){} 
        }
        else{}
%>  
