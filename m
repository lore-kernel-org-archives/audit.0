Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5521FF7B5;
	Thu, 24 Oct 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792758; cv=none; b=XPdCYfYwyZ47aDAxAUE8HYoVyd/fl+DV8aQWFO4UC7YQPD/W0E7SBNLjSOs64IbK/1+jECjLYoS2iTwTPa/HkngNCL/HJeGzd494TzjTdthlM1GVApEklsMP5CLyeejYMspBtqiDaEt0HWi//ZUy+z++2o2mkCDXZbqNRqR0ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792758; c=relaxed/simple;
	bh=O9w3Rzjo7NYxEqBTRuRG1jmrpmTfVEMjygY8WcCSMuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4CubViUImIl7z6A5h6yA6PG/eDw/BSzESKGXP5dDtYrlJ4iksIqqN3nNqHxUvPoB3Y7IoQ9raXCe4hf9QPxhszHgV5kyP0OUkHbMZI4n/Kwz8b390ivWF8e3B+HW9rSBPNbkyKiF4++v/9krJsN+ux/ICyVOykC1MQPOzS+kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH/uMs+0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH/uMs+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729792755; x=1761328755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O9w3Rzjo7NYxEqBTRuRG1jmrpmTfVEMjygY8WcCSMuI=;
  b=JH/uMs+0KOv/1G+KuKH4KXo69UyqlH06QKlHwqfChSER4xh4O7Q1mBdz
   MAOonc4ErnjuTni1m120iaFT7242xc+kDB1kus8oQe17wv+fs+oTI8b4+
   oILb3T6iLmujwLneG32CgnqvJ+D+Y2mlgK+7oUmD3oipCsZIv0txEHwsH
   2o5UjBF1VCdtf0QiWouCeaKId7atIrLVefTmmwSvXIIqJhpwCDSZK9GYb
   A0WwrAPCSgfElkXeFdV300gLLrDS5nzg5QEFPM1jyss6sTSxHQSzV56W3
   KAf6/EXio5vshxetWbu+Ic3KsuirotGsj2e7/mhgwz8DhbBXVoVYCXcKf
   A==;
X-CSE-ConnectionGUID: n8ZK9pwTTNaGGE8byvWSHQ==
X-CSE-MsgGUID: pc1Sf7xOTVqMoxSauYD6iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29345427"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29345427"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:59:12 -0700
X-CSE-ConnectionGUID: itbWSTKIQKKgGLqETZRhVQ==
X-CSE-MsgGUID: Zk47DwNAQR2Ozc5nyx4iVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111471520"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 10:59:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4271-000Wos-3B;
	Thu, 24 Oct 2024 17:59:07 +0000
Date: Fri, 25 Oct 2024 01:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Guy Briggs <rgb@redhat.com>,
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v1] audit,module: restore audit logging in load failure
 case
Message-ID: <202410250152.vcJ5tyVZ-lkp@intel.com>
References: <999cdd694f951acd2f4ad665fe7ab97d0834e162.1729717542.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999cdd694f951acd2f4ad665fe7ab97d0834e162.1729717542.git.rgb@redhat.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on mcgrof/modules-next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Briggs/audit-module-restore-audit-logging-in-load-failure-case/20241024-051515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/999cdd694f951acd2f4ad665fe7ab97d0834e162.1729717542.git.rgb%40redhat.com
patch subject: [PATCH v1] audit,module: restore audit logging in load failure case
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241025/202410250152.vcJ5tyVZ-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250152.vcJ5tyVZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250152.vcJ5tyVZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/module/main.c:14:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/module/main.c:3336:25: error: passing 'const char *' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    3336 |                 audit_log_kern_module(info->name ? info->name : "(unavailable)");
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/audit.h:522:48: note: passing argument to parameter 'name' here
     522 | static inline void audit_log_kern_module(char *name)
         |                                                ^
   4 warnings and 1 error generated.


vim +3336 kernel/module/main.c

  3124	
  3125	/*
  3126	 * Allocate and load the module: note that size of section 0 is always
  3127	 * zero, and we rely on this for optional sections.
  3128	 */
  3129	static int load_module(struct load_info *info, const char __user *uargs,
  3130			       int flags)
  3131	{
  3132		struct module *mod;
  3133		bool module_allocated = false;
  3134		long err = 0;
  3135		char *after_dashes;
  3136	
  3137		/*
  3138		 * Do the signature check (if any) first. All that
  3139		 * the signature check needs is info->len, it does
  3140		 * not need any of the section info. That can be
  3141		 * set up later. This will minimize the chances
  3142		 * of a corrupt module causing problems before
  3143		 * we even get to the signature check.
  3144		 *
  3145		 * The check will also adjust info->len by stripping
  3146		 * off the sig length at the end of the module, making
  3147		 * checks against info->len more correct.
  3148		 */
  3149		err = module_sig_check(info, flags);
  3150		if (err)
  3151			goto free_copy;
  3152	
  3153		/*
  3154		 * Do basic sanity checks against the ELF header and
  3155		 * sections. Cache useful sections and set the
  3156		 * info->mod to the userspace passed struct module.
  3157		 */
  3158		err = elf_validity_cache_copy(info, flags);
  3159		if (err)
  3160			goto free_copy;
  3161	
  3162		err = early_mod_check(info, flags);
  3163		if (err)
  3164			goto free_copy;
  3165	
  3166		/* Figure out module layout, and allocate all the memory. */
  3167		mod = layout_and_allocate(info, flags);
  3168		if (IS_ERR(mod)) {
  3169			err = PTR_ERR(mod);
  3170			goto free_copy;
  3171		}
  3172	
  3173		module_allocated = true;
  3174	
  3175		audit_log_kern_module(mod->name);
  3176	
  3177		/* Reserve our place in the list. */
  3178		err = add_unformed_module(mod);
  3179		if (err)
  3180			goto free_module;
  3181	
  3182		/*
  3183		 * We are tainting your kernel if your module gets into
  3184		 * the modules linked list somehow.
  3185		 */
  3186		module_augment_kernel_taints(mod, info);
  3187	
  3188		/* To avoid stressing percpu allocator, do this once we're unique. */
  3189		err = percpu_modalloc(mod, info);
  3190		if (err)
  3191			goto unlink_mod;
  3192	
  3193		/* Now module is in final location, initialize linked lists, etc. */
  3194		err = module_unload_init(mod);
  3195		if (err)
  3196			goto unlink_mod;
  3197	
  3198		init_param_lock(mod);
  3199	
  3200		/*
  3201		 * Now we've got everything in the final locations, we can
  3202		 * find optional sections.
  3203		 */
  3204		err = find_module_sections(mod, info);
  3205		if (err)
  3206			goto free_unload;
  3207	
  3208		err = check_export_symbol_versions(mod);
  3209		if (err)
  3210			goto free_unload;
  3211	
  3212		/* Set up MODINFO_ATTR fields */
  3213		setup_modinfo(mod, info);
  3214	
  3215		/* Fix up syms, so that st_value is a pointer to location. */
  3216		err = simplify_symbols(mod, info);
  3217		if (err < 0)
  3218			goto free_modinfo;
  3219	
  3220		err = apply_relocations(mod, info);
  3221		if (err < 0)
  3222			goto free_modinfo;
  3223	
  3224		err = post_relocation(mod, info);
  3225		if (err < 0)
  3226			goto free_modinfo;
  3227	
  3228		flush_module_icache(mod);
  3229	
  3230		/* Now copy in args */
  3231		mod->args = strndup_user(uargs, ~0UL >> 1);
  3232		if (IS_ERR(mod->args)) {
  3233			err = PTR_ERR(mod->args);
  3234			goto free_arch_cleanup;
  3235		}
  3236	
  3237		init_build_id(mod, info);
  3238	
  3239		/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
  3240		ftrace_module_init(mod);
  3241	
  3242		/* Finally it's fully formed, ready to start executing. */
  3243		err = complete_formation(mod, info);
  3244		if (err)
  3245			goto ddebug_cleanup;
  3246	
  3247		err = prepare_coming_module(mod);
  3248		if (err)
  3249			goto bug_cleanup;
  3250	
  3251		mod->async_probe_requested = async_probe;
  3252	
  3253		/* Module is ready to execute: parsing args may do that. */
  3254		after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
  3255					  -32768, 32767, mod,
  3256					  unknown_module_param_cb);
  3257		if (IS_ERR(after_dashes)) {
  3258			err = PTR_ERR(after_dashes);
  3259			goto coming_cleanup;
  3260		} else if (after_dashes) {
  3261			pr_warn("%s: parameters '%s' after `--' ignored\n",
  3262			       mod->name, after_dashes);
  3263		}
  3264	
  3265		/* Link in to sysfs. */
  3266		err = mod_sysfs_setup(mod, info, mod->kp, mod->num_kp);
  3267		if (err < 0)
  3268			goto coming_cleanup;
  3269	
  3270		if (is_livepatch_module(mod)) {
  3271			err = copy_module_elf(mod, info);
  3272			if (err < 0)
  3273				goto sysfs_cleanup;
  3274		}
  3275	
  3276		/* Get rid of temporary copy. */
  3277		free_copy(info, flags);
  3278	
  3279		codetag_load_module(mod);
  3280	
  3281		/* Done! */
  3282		trace_module_load(mod);
  3283	
  3284		return do_init_module(mod);
  3285	
  3286	 sysfs_cleanup:
  3287		mod_sysfs_teardown(mod);
  3288	 coming_cleanup:
  3289		mod->state = MODULE_STATE_GOING;
  3290		destroy_params(mod->kp, mod->num_kp);
  3291		blocking_notifier_call_chain(&module_notify_list,
  3292					     MODULE_STATE_GOING, mod);
  3293		klp_module_going(mod);
  3294	 bug_cleanup:
  3295		mod->state = MODULE_STATE_GOING;
  3296		/* module_bug_cleanup needs module_mutex protection */
  3297		mutex_lock(&module_mutex);
  3298		module_bug_cleanup(mod);
  3299		mutex_unlock(&module_mutex);
  3300	
  3301	 ddebug_cleanup:
  3302		ftrace_release_mod(mod);
  3303		synchronize_rcu();
  3304		kfree(mod->args);
  3305	 free_arch_cleanup:
  3306		module_arch_cleanup(mod);
  3307	 free_modinfo:
  3308		free_modinfo(mod);
  3309	 free_unload:
  3310		module_unload_free(mod);
  3311	 unlink_mod:
  3312		mutex_lock(&module_mutex);
  3313		/* Unlink carefully: kallsyms could be walking list. */
  3314		list_del_rcu(&mod->list);
  3315		mod_tree_remove(mod);
  3316		wake_up_all(&module_wq);
  3317		/* Wait for RCU-sched synchronizing before releasing mod->list. */
  3318		synchronize_rcu();
  3319		mutex_unlock(&module_mutex);
  3320	 free_module:
  3321		mod_stat_bump_invalid(info, flags);
  3322		/* Free lock-classes; relies on the preceding sync_rcu() */
  3323		for_class_mod_mem_type(type, core_data) {
  3324			lockdep_free_key_range(mod->mem[type].base,
  3325					       mod->mem[type].size);
  3326		}
  3327	
  3328		module_deallocate(mod, info);
  3329	 free_copy:
  3330		/*
  3331		 * The info->len is always set. We distinguish between
  3332		 * failures once the proper module was allocated and
  3333		 * before that.
  3334		 */
  3335		if (!module_allocated) {
> 3336			audit_log_kern_module(info->name ? info->name : "(unavailable)");
  3337			mod_stat_bump_becoming(info, flags);
  3338		}
  3339		free_copy(info, flags);
  3340		return err;
  3341	}
  3342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
