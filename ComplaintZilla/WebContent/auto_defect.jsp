<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>


 
   <%
   try{
     String s[]=null;
 	String str1=null;
 	Connection con = Connection_Utility.getConnection();
     Statement st=con.createStatement();
     ResultSet rs = st.executeQuery("select * from Defect_Tbl");
 
       List li = new ArrayList();
 
       while(rs.next())
       {
           li.add(rs.getString("Defect_Type"));
       }
 
       String[] str = new String[li.size()];
       Iterator it = li.iterator();
 		
       int i = 0;
       while(it.hasNext())
       {
           String p = (String)it.next();
           str[i] = p;
           i++;
      
       }
      

    //jQuery related start
       String query = (String)request.getParameter("q");
 
       int cnt=1;
       for(int j=0;j<str.length;j++)
       {
           if(str[j].toUpperCase().startsWith(query.toUpperCase()))
           {
              out.print(str[j]+"\n");
              if(cnt>=15)// 15=How many results have to show while we are typing(auto suggestions)
              break;
              cnt++;
            }
       }
    //jQuery related end
 
rs.close();
st.close();
con.close();

}
catch(Exception e){
e.printStackTrace();
}
 
//www.java4s.com
%>