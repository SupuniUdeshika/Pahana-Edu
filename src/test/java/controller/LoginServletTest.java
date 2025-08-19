package controller;

import dao.UserDAO;
import model.User;
import org.junit.*;
import org.mockito.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;

import java.io.PrintWriter;
import java.io.StringWriter;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class LoginServletTest {

    @InjectMocks
    private LoginServlet loginServlet;

    @Mock
    private UserDAO userDAO;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private RequestDispatcher dispatcher;

    private StringWriter responseWriter;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
        responseWriter = new StringWriter();
        when(response.getWriter()).thenReturn(new PrintWriter(responseWriter));
    }

    @Test
    public void testSuccessfulLogin() throws Exception {
        User user = new User("Admin", "admin@example.com", "1234", "ADMIN");
        user.setVerified(true);

        when(request.getParameter("email")).thenReturn("admin@example.com");
        when(request.getParameter("password")).thenReturn("1234");
        when(request.getSession(false)).thenReturn(null);
        when(request.getSession(true)).thenReturn(session);

        when(userDAO.getUserByEmail("admin@example.com")).thenReturn(user);

        loginServlet.setUserDAO(userDAO);
        loginServlet.doPost(request, response);

        verify(session).setAttribute("user", user);
        assertTrue(responseWriter.toString().contains("Admindashboard.jsp"));
    }

    @Test
    public void testInvalidLogin() throws Exception {
        when(request.getParameter("email")).thenReturn("wrong@example.com");
        when(request.getParameter("password")).thenReturn("wrongpass");
        when(request.getRequestDispatcher("/Auth/index.jsp")).thenReturn(dispatcher);

        when(userDAO.getUserByEmail("wrong@example.com")).thenReturn(null);

        loginServlet.setUserDAO(userDAO);
        loginServlet.doPost(request, response);

        verify(request).setAttribute(eq("errorMessage"), anyString());
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testUnverifiedUserLogin() throws Exception {
        User user = new User("Cashier", "cashier@example.com", "abcd", "CASHIER");
        user.setVerified(false);

        when(request.getParameter("email")).thenReturn("cashier@example.com");
        when(request.getParameter("password")).thenReturn("abcd");
        when(request.getRequestDispatcher("/Auth/index.jsp")).thenReturn(dispatcher);

        when(userDAO.getUserByEmail("cashier@example.com")).thenReturn(user);

        loginServlet.setUserDAO(userDAO);
        loginServlet.doPost(request, response);

        verify(request).setAttribute(eq("errorMessage"), contains("not verified"));
        verify(dispatcher).forward(request, response);
    }
}
