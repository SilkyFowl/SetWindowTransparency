public static List<IntPtr> SearchForWindow(string wndclass, string title)
{
	SearchData sd = new SearchData { Wndclass = wndclass, Title = title, hWnd = new List<IntPtr>() };
	EnumWindows(new EnumWindowsProc(EnumProc), ref sd);
	return sd.hWnd;
}

public static List<IntPtr> SearchForWindow(int processId)
{
	SearchData sd = new SearchData { Wndclass = "", Title = "",ProcessId = processId, hWnd = new List<IntPtr>() };
	EnumWindows(new EnumWindowsProc(EnumProc), ref sd);
	return sd.hWnd;
}


public static bool EnumProc(IntPtr hWnd, ref SearchData data)
{
	// Check classname and title
	// This is different from FindWindow() in that the code below allows partial matches
	StringBuilder sb = new StringBuilder(1024);
	GetClassName(hWnd, sb, sb.Capacity);
	if (!string.IsNullOrEmpty(data.Wndclass)
		& !sb.ToString().StartsWith(data.Wndclass))
	{
		return true;
	}
	sb.Clear();
	GetWindowText(hWnd, sb, sb.Capacity);
	if (!string.IsNullOrEmpty(data.Title)
		& !(sb.ToString().Contains(data.Title)))
	{
		return true;
	}

	int processId;
	GetWindowThreadProcessId(hWnd, out processId);
	if (data.ProcessId.HasValue
		& data.ProcessId != processId)
	{
		return true;
	}
	data.hWnd.Add(hWnd);
	return true;
}

public class SearchData
{
	// You can put any dicks or Doms in here...
	public string Wndclass;
	public string Title;

	public int? ProcessId;
	public List<IntPtr> hWnd;
}

private delegate bool EnumWindowsProc(IntPtr hWnd, ref SearchData data);

[DllImport("user32.dll")]
[return: MarshalAs(UnmanagedType.Bool)]
private static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, ref SearchData data);

[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);

[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

[DllImport("user32.dll", SetLastError = true)]
private static extern int GetWindowThreadProcessId(IntPtr hWnd, out int lpdwProcessId);
