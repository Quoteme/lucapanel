#include "my_application.h"
#include "gdk/gdk.h"
#include "gtk/gtk.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <X11/Xatom.h>
#include <gdk/gdkx.h>
#endif

#include "flutter/generated_plugin_registrant.h"

struct _MyApplication {
  GtkApplication parent_instance;
  char **dart_entrypoint_arguments;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

void get_monitor_width_and_height(GdkWindow *gdkWindow, int *width,
                                  int *height) {
  *width = 1919;
  *height = 1080;
}

void set_net_wm_strut_partial(GtkWindow *window, int width = 1200,
                              int height = 32) {
  GdkWindow *gdkWindow = gtk_widget_get_window(GTK_WIDGET(window));
  Display *display = GDK_WINDOW_XDISPLAY(gdkWindow);

  Window xwindow = GDK_WINDOW_XID(gdkWindow);

  Atom property = XInternAtom(display, "_NET_WM_STRUT_PARTIAL", False);
  long strut[12] = {0, 0, height, 0, 0, 0, 0, 0, 0, width, 0, 0};

  XChangeProperty(display, xwindow, property, XA_CARDINAL, 32, PropModeReplace,
                  (unsigned char *)strut, 12);
  XFlush(display);
}

// Implements GApplication::activate.
static void my_application_activate(GApplication *application) {
  MyApplication *self = MY_APPLICATION(application);
  GtkWindow *window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  int screen_width, screen_height;
  int panel_height = 32;
  // print the monitor width and height
  get_monitor_width_and_height(gtk_widget_get_window(GTK_WIDGET(window)),
                               &screen_width, &screen_height);

  gtk_window_set_title(window, "lucapanel");
  gtk_window_set_gravity(window, GDK_GRAVITY_STATIC);
  gtk_window_set_default_size(window, screen_width, panel_height);
  gtk_window_move(window, 0, 0);
  gtk_window_set_type_hint(window, GDK_WINDOW_TYPE_HINT_DOCK);
  gtk_window_set_role(window, "Panel");

  gtk_widget_show(GTK_WIDGET(window));

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(
      project, self->dart_entrypoint_arguments);

  FlView *view = fl_view_new(project);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_widget_grab_focus(GTK_WIDGET(view));

  set_net_wm_strut_partial(window, screen_width, panel_height);
}

// Implements GApplication::local_command_line.
static gboolean my_application_local_command_line(GApplication *application,
                                                  gchar ***arguments,
                                                  int *exit_status) {
  MyApplication *self = MY_APPLICATION(application);
  // Strip out the first argument as it is the binary name.
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);

  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
    g_warning("Failed to register: %s", error->message);
    *exit_status = 1;
    return TRUE;
  }

  g_application_activate(application);
  *exit_status = 0;

  return TRUE;
}

// Implements GObject::dispose.
static void my_application_dispose(GObject *object) {
  MyApplication *self = MY_APPLICATION(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}

static void my_application_class_init(MyApplicationClass *klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
  G_APPLICATION_CLASS(klass)->local_command_line =
      my_application_local_command_line;
  G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}

static void my_application_init(MyApplication *self) {}

MyApplication *my_application_new() {
  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id", APPLICATION_ID, "flags",
                                     G_APPLICATION_NON_UNIQUE, nullptr));
}
