using System;
using Android.Content;
using Android.Graphics;
using Android.Widget;
using AndroidX.Preference;
using WoWonder.Helpers.Utils;

namespace WoWonder.Activities.SettingsPreferences.Custom
{
    public class CustomSwitchPreference : SwitchPreferenceCompat
    {
        public CustomSwitchPreference(Context context) : base(context)
        {

        }

        public CustomSwitchPreference(Context context, Android.Util.IAttributeSet attrs) : base(context, attrs)
        {
            try
            {
                LayoutResource = Resource.Layout.SettingCustomSwitch;
            }
            catch (Exception e)
            {
                Methods.DisplayReportResultTrack(e);
            }
        }

        public override void OnBindViewHolder(PreferenceViewHolder holder)
        {
            try
            {
                base.OnBindViewHolder(holder);

                holder.ItemView.SetBackgroundColor(AppSettings.SetTabDarkTheme ? Color.ParseColor("#444444") : Color.ParseColor("#ffffff"));

                var title = holder.ItemView.FindViewById<TextView>(Resource.Id.title);
                title.SetTextColor(AppSettings.SetTabDarkTheme ? Color.ParseColor("#ffffff") : Color.ParseColor("#444444"));
                title.Text = Title;

                var summary = holder.ItemView.FindViewById<TextView>(Resource.Id.summary);
                summary.SetTextColor(AppSettings.SetTabDarkTheme ? Color.ParseColor("#ffffff") : Color.ParseColor("#CECECE"));
                summary.Text = Summary;

                var swithc = holder.ItemView.FindViewById<Switch>(Resource.Id.togglebutton);
                swithc.Checked = Checked;
            }
            catch (Exception e)
            {
                Methods.DisplayReportResultTrack(e);
            }
        }
    }
}