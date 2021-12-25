public class Hello
{
  public static String sayHello (int n)
  {
    String result = new String("Hello");
    for(int i=1; i<n; i++)
    {
      result += " Hello";
    }
    return result;
  }
}
