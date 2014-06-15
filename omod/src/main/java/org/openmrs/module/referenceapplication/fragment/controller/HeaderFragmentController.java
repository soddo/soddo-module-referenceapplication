package org.openmrs.module.referenceapplication.fragment.controller;

import java.util.List;
import java.util.Map;

import org.openmrs.api.context.Context;
import org.openmrs.module.appframework.domain.Extension;
import org.openmrs.module.appframework.service.AppFrameworkService;
import org.openmrs.module.appui.AppUiExtensions;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.util.PrivilegeConstants;

public class HeaderFragmentController {
	 public void controller(@SpringBean AppFrameworkService appFrameworkService, FragmentModel fragmentModel) {
	        try {
	            Context.addProxyPrivilege(PrivilegeConstants.VIEW_LOCATIONS);
	            fragmentModel.addAttribute("loginLocations", appFrameworkService.getLoginLocations());

	            List<Extension> exts = appFrameworkService.getExtensionsForCurrentUser(AppUiExtensions.HEADER_CONFIG_EXTENSION);
	            Map<String, Object> configSettings = exts.size() > 0 ? exts.get(0).getExtensionParams() : null;
	            fragmentModel.addAttribute("configSettings", configSettings);
	        } finally {
	            Context.removeProxyPrivilege(PrivilegeConstants.VIEW_LOCATIONS);
	        }
	    }


}
