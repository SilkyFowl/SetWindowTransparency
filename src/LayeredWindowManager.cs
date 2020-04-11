[DllImport("user32.dll")]
public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

[DllImport("user32.dll")]
public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

[DllImport("user32.dll", SetLastError = true)]
public static extern bool SetLayeredWindowAttributes(IntPtr hWnd, uint crKey, int bAlpha, uint dwFlags);
