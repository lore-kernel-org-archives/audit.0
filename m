Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E9E810DB
	for <audit@archiver.kernel.org>; Wed, 27 Sep 2023 12:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjI0MUi (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 27 Sep 2023 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjI0MUh (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 27 Sep 2023 08:20:37 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436B1B1
        for <audit@vger.kernel.org>; Wed, 27 Sep 2023 05:20:29 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 35CE63F6B0;
        Wed, 27 Sep 2023 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695817227;
        bh=mGF8OAfCXdQsAHc8Bm0HdixcrClAR7+8+o5cDtj5bVE=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=H5AnDg9YqRryqzfs9uPZJr5GhKxnAoDVrtHzyQdvPOD/mtnnbQLGT/+na5RgLW5qR
         XjE78QMyYSmKide56yfzPWYmDyGYZhOVJmCBusT85WHbVI1WUlr5I1jk0D5cUj5eOO
         A0KkZ3rLZu8/+uvGZW+V78xnEiQeKEs1NxlOc6XJ6gHkMblqTeJX/rSwNrHOJbT9wv
         R3L54lDoja3eZyfixODqitoYCqy0RQt7fedmb1sW+P0xxZvCRH8ox2DKDfaSjlzuDi
         3gacR/R7BkGgXOxLgbDm5D3d6cYBU4j4Leph/Gtnv38qQghRR9cJX8mjd3LWkKzVy3
         hyM1XvGeTq25Q==
Message-ID: <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com>
Date:   Wed, 27 Sep 2023 05:20:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [apparmor] AppArmor kernel audit locks up system
Content-Language: en-US
To:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
Cc:     "paul@paul-moore.com >> Paul Moore" <paul@paul-moore.com>,
        audit@vger.kernel.org
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

adding paul and the audit list

On 9/26/23 05:56, Andreas Steinmetz wrote:
> Hi,
> it happen from time to time while setting up AppArmor properly that
> instead of creating an audit message AppArmor locks up the system. In
> most cases I couldn't even get any information, but this time I got
> some.
> I don't yet know if this is the case here but in case of "systemd
> --user" it was a missing grant of cap_sys_resource that caused the
> lockup. I don't know the exact capability causing the below problem
> but granting cap_sys_admin, cap_setuid, cap_setgid and
> cap_sys_resource prevents the lockup so it is definitely capability
> related. dmesg output follows. Kernel is 6.5.3, distro is Arch Linux.
> 

just to double check, you are using auditd and have some audit filters
loaded, the code trace indicates yes.

so at a first pass it appears this come when the task calls prlimit64,
the capability check is denied and apparmor (or really any lsm).
generates an audit message. The audit message goes into the audit
subsystems, and there an exe filter which tries to get the task_exe_file
resulting in deadlock.

do_prlimit()
	task_lock(tsk->group_leader);
            ...
			if (new_rlim->rlim_max > rlim->rlim_max &&
				!capable(CAP_SYS_RESOURCE))
					...
					case AUDIT_EXE:
						result = audit_exe_compare(current, e->rule.exe)
							...
							struct file *get_task_exe_file(struct task_struct *task)
								...
								task_lock(task);
								...
            ...
	task_unlock(tsk->group_leader);


I am not sure how best to handle this.




> [ 3762.613322] watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [sudo:38886]
> [ 3762.613328] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> xt_tcpudp nft_compat sit tunnel4 ip_tunnel bridge nft_chain_nat nf_nat 8021q gar
> p mrp stp nf_tables llc nfnetlink snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence
> snd_sof_intel_hda snd_s
> of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
> soundwire_generic_allocation soun
> dwire_bus snd_soc_skl intel_rapl_msr intel_rapl_common
> intel_tcc_cooling snd_soc_
> hdac_hda snd_hda_ext_core vfat fat x86_pkg_temp_thermal
> [ 3762.613372]  intel_powerclamp snd_soc_sst_ipc snd_soc_sst_dsp
> kvm_intel snd_so
> c_acpi_intel_match snd_soc_acpi kvm snd_hda_codec_hdmi irqbypass
> snd_soc_core snd
> _hda_codec_realtek iwlmvm crct10dif_pclmul crc32_pclmul
> snd_hda_codec_generic snd
> _compress polyval_clmulni ledtrig_audio polyval_generic ac97_bus
> mac80211 snd_pcm
> _dmaengine gf128mul ghash_clmulni_intel sha512_ssse3 snd_hda_intel libarc4 btusb
> aesni_intel snd_intel_dspcfg mei_pxp mei_hdcp ee1004 crypto_simd btrtl
> iTCO_wdt i
> ntel_pmc_bxt btbcm snd_intel_sdw_acpi cryptd iTCO_vendor_support btintel iwlwifi
> snd_hda_codec rapl btmtk snd_hda_core intel_cstate bluetooth spi_nor
> cfg80211 snd
> _hwdep snd_pcm mei_me igb ecdh_generic e1000e wmi_bmof mtd snd_timer
> intel_uncore
> rfkill i2c_i801 pcspkr snd mei i2c_smbus soundcore dca intel_pch_thermal acpi_pa
> d acpi_tad joydev mousedev mac_hid wireguard curve25519_x86_64
> libchacha20poly130
> 5 chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha pppoe
> pppox ppp_g
> eneric slhc nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> [ 3762.613416]  dm_multipath coretemp gfs2 nfsd dlm auth_rpcgss
> nfs_acl sctp lock
> d grace ip6_udp_tunnel udp_tunnel libcrc32c sg sunrpc crypto_user fuse
> loop ip_ta
> bles x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid i915
> dm_mod raid1 i2c
> _algo_bit drm_buddy ttm md_mod nvme intel_gtt nvme_core crc32c_intel
> drm_display_
> helper spi_intel_pci spi_intel xhci_pci nvme_common cec
> xhci_pci_renesas video wm
> i
> [ 3762.613439] CPU: 6 PID: 38886 Comm: sudo Not tainted 6.5.3-arch1-1
> #1 ed5b3b89
> 4d0aeb37298a77837232ca9b353cc27d
> [ 3762.613442] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3762.613443] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3762.613448] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3762.613450] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3762.613452] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3762.613453] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3762.613454] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3762.613456] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3762.613457] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3762.613458] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3762.613461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3762.613462] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3762.613463] Call Trace:
> [ 3762.613464]  <IRQ>
> [ 3762.613467]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3762.613470]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3762.613472]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3762.613475]  ? hrtimer_interrupt+0xf8/0x230
> [ 3762.613478]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3762.613481]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3762.613484]  </IRQ>
> [ 3762.613485]  <TASK>
> [ 3762.613485]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3762.613488]  ? __pfx_audit_cb+0x10/0x10
> [ 3762.613492]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3762.613495]  _raw_spin_lock+0x29/0x30
> [ 3762.613497]  get_task_exe_file+0x1f/0x70
> [ 3762.613501]  audit_exe_compare+0x15/0x60
> [ 3762.613504]  audit_filter+0x161/0x270
> [ 3762.613506]  ? __pfx_audit_cb+0x10/0x10
> [ 3762.613508]  audit_log_start+0x64/0x3c0
> [ 3762.613511]  ? __pfx_audit_pre+0x10/0x10
> [ 3762.613512]  ? __pfx_audit_cb+0x10/0x10
> [ 3762.613514]  common_lsm_audit+0x5f/0x910
> [ 3762.613517]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3762.613519]  aa_audit+0x5d/0x180
> [ 3762.613521]  aa_capable+0x1fd/0x400
> [ 3762.613525]  apparmor_capable+0xa5/0x190
> [ 3762.613527]  security_capable+0x41/0x70
> [ 3762.613531]  capable+0x2f/0x60
> [ 3762.613533]  do_prlimit+0x91/0x220
> [ 3762.613536]  __do_sys_prlimit64+0x22d/0x300
> [ 3762.613539]  do_syscall_64+0x5d/0x90
> [ 3762.613542]  ? audit_reset_context+0x232/0x300
> [ 3762.613544]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3762.613546]  ? do_syscall_64+0x6c/0x90
> [ 3762.613549]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3762.613551]  ? do_syscall_64+0x6c/0x90
> [ 3762.613553]  ? exc_page_fault+0x7f/0x180
> [ 3762.613556]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3762.613558] RIP: 0033:0x7f6be3905265
> [ 3762.613584] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3762.613586] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3762.613587] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3762.613588] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3762.613589] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3762.613590] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3762.613591] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3762.613593]  </TASK>
> [ 3763.656926] igb 0000:01:00.0: clearing Tx timestamp hang
> [ 3770.613148] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [ps:38979]
> [ 3770.613152] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> xt_tcpudp nft_compat sit tunnel4 ip_tunnel bridge nft_chain_nat nf_nat 8021q gar
> p mrp stp nf_tables llc nfnetlink snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence
> snd_sof_intel_hda snd_s
> of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
> soundwire_generic_allocation soun
> dwire_bus snd_soc_skl intel_rapl_msr intel_rapl_common
> intel_tcc_cooling snd_soc_
> hdac_hda snd_hda_ext_core vfat fat x86_pkg_temp_thermal
> [ 3770.613196]  intel_powerclamp snd_soc_sst_ipc snd_soc_sst_dsp
> kvm_intel snd_so
> c_acpi_intel_match snd_soc_acpi kvm snd_hda_codec_hdmi irqbypass
> snd_soc_core snd
> _hda_codec_realtek iwlmvm crct10dif_pclmul crc32_pclmul
> snd_hda_codec_generic snd
> _compress polyval_clmulni ledtrig_audio polyval_generic ac97_bus
> mac80211 snd_pcm
> _dmaengine gf128mul ghash_clmulni_intel sha512_ssse3 snd_hda_intel libarc4 btusb
> aesni_intel snd_intel_dspcfg mei_pxp mei_hdcp ee1004 crypto_simd btrtl
> iTCO_wdt i
> ntel_pmc_bxt btbcm snd_intel_sdw_acpi cryptd iTCO_vendor_support btintel iwlwifi
> snd_hda_codec rapl btmtk snd_hda_core intel_cstate bluetooth spi_nor
> cfg80211 snd
> _hwdep snd_pcm mei_me igb ecdh_generic e1000e wmi_bmof mtd snd_timer
> intel_uncore
> rfkill i2c_i801 pcspkr snd mei i2c_smbus soundcore dca intel_pch_thermal acpi_pa
> d acpi_tad joydev mousedev mac_hid wireguard curve25519_x86_64
> libchacha20poly130
> 5 chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha pppoe
> pppox ppp_g
> eneric slhc nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> [ 3770.613240]  dm_multipath coretemp gfs2 nfsd dlm auth_rpcgss
> nfs_acl sctp lock
> d grace ip6_udp_tunnel udp_tunnel libcrc32c sg sunrpc crypto_user fuse
> loop ip_ta
> bles x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid i915
> dm_mod raid1 i2c
> _algo_bit drm_buddy ttm md_mod nvme intel_gtt nvme_core crc32c_intel
> drm_display_
> helper spi_intel_pci spi_intel xhci_pci nvme_common cec
> xhci_pci_renesas video wm
> i
> [ 3770.613263] CPU: 4 PID: 38979 Comm: ps Tainted: G             L
> 6.5.3-arch
> 1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3770.613266] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3770.613267] RIP: 0010:native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3770.613272] Code: c5 01 41 c1 e4 10 41 c1 e5 12 45 09 ec 44 89 e0 c1 e8 10 66
> 87 43 02 89 c2 c1 e2 10 81 fa ff ff 00 00 77 5e 31 d2 eb 02 f3 90 <8b>
> 03 66 85 c
> 0 75 f7 44 39 e0 0f 84 8e 00 00 00 c6 03 01 48 85 d2
> [ 3770.613274] RSP: 0018:ffffb19a85643dc0 EFLAGS: 00000202
> [ 3770.613275] RAX: 0000000000140101 RBX: ffff8dede1760900 RCX: 0000000000000001
> [ 3770.613276] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8dede1760900
> [ 3770.613278] RBP: ffff8df4c2734dc0 R08: ffff8ded812f69d0 R09: 0000000000000000
> [ 3770.613279] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
> [ 3770.613279] R13: 0000000000140000 R14: ffffb19a85643ea0 R15: ffffffffa1250c60
> [ 3770.613280] FS:  00007f3cf6e644c0(0000) GS:ffff8df4c2700000(0000)
> knlGS:000000
> 0000000000
> [ 3770.613282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3770.613283] CR2: 00007f3cf63ff000 CR3: 00000001c41c4002 CR4: 00000000003706e0
> [ 3770.613284] Call Trace:
> [ 3770.613285]  <IRQ>
> [ 3770.613287]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3770.613290]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3770.613293]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3770.613296]  ? hrtimer_interrupt+0xf8/0x230
> [ 3770.613298]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3770.613301]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3770.613304]  </IRQ>
> [ 3770.613305]  <TASK>
> [ 3770.613306]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3770.613311]  ? native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3770.613315]  _raw_spin_lock+0x29/0x30
> [ 3770.613317]  ptrace_may_access+0x21/0x50
> [ 3770.613321]  proc_pid_readdir+0x8e/0x220
> [ 3770.613323]  iterate_dir+0x90/0x170
> [ 3770.613327]  __x64_sys_getdents64+0x88/0x130
> [ 3770.613329]  ? __pfx_filldir64+0x10/0x10
> [ 3770.613332]  do_syscall_64+0x5d/0x90
> [ 3770.613334]  ? exc_page_fault+0x7f/0x180
> [ 3770.613337]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3770.613339] RIP: 0033:0x7f3cf6cd63b7
> [ 3770.613366] Code: 33 fb ff 48 83 c4 08 48 89 e8 5b 5d c3 66 0f 1f 44 00 00 f3
> 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48>
> 3d 00 f0 f
> f ff 77 01 c3 48 8b 15 49 79 16 00 f7 d8 64 89 02 48
> [ 3770.613367] RSP: 002b:00007ffecbf3a018 EFLAGS: 00000293 ORIG_RAX:
> 000000000000
> 00d9
> [ 3770.613369] RAX: ffffffffffffffda RBX: 000055d96db4a2b0 RCX: 00007f3cf6cd63b7
> [ 3770.613370] RDX: 0000000000008000 RSI: 000055d96db4a2e0 RDI: 0000000000000003
> [ 3770.613371] RBP: 000055d96db4a2b4 R08: 000055d96db302d8 R09: ffffffffffffc000
> [ 3770.613372] R10: 00007f3cf636b030 R11: 0000000000000293 R12: 000055d96db4a2e0
> [ 3770.613372] R13: fffffffffffff2d8 R14: 0000000000000000 R15: 00000000ffffffff
> [ 3770.613375]  </TASK>
> [ 3790.612813] watchdog: BUG: soft lockup - CPU#6 stuck for 52s! [sudo:38886]
> [ 3790.612819] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> xt_tcpudp nft_compat sit tunnel4 ip_tunnel bridge nft_chain_nat nf_nat 8021q gar
> p mrp stp nf_tables llc nfnetlink snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence
> snd_sof_intel_hda snd_s
> of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
> soundwire_generic_allocation soun
> dwire_bus snd_soc_skl intel_rapl_msr intel_rapl_common
> intel_tcc_cooling snd_soc_
> hdac_hda snd_hda_ext_core vfat fat x86_pkg_temp_thermal
> [ 3790.612862]  intel_powerclamp snd_soc_sst_ipc snd_soc_sst_dsp
> kvm_intel snd_so
> c_acpi_intel_match snd_soc_acpi kvm snd_hda_codec_hdmi irqbypass
> snd_soc_core snd
> _hda_codec_realtek iwlmvm crct10dif_pclmul crc32_pclmul
> snd_hda_codec_generic snd
> _compress polyval_clmulni ledtrig_audio polyval_generic ac97_bus
> mac80211 snd_pcm
> _dmaengine gf128mul ghash_clmulni_intel sha512_ssse3 snd_hda_intel libarc4 btusb
> aesni_intel snd_intel_dspcfg mei_pxp mei_hdcp ee1004 crypto_simd btrtl
> iTCO_wdt i
> ntel_pmc_bxt btbcm snd_intel_sdw_acpi cryptd iTCO_vendor_support btintel iwlwifi
> snd_hda_codec rapl btmtk snd_hda_core intel_cstate bluetooth spi_nor
> cfg80211 snd
> _hwdep snd_pcm mei_me igb ecdh_generic e1000e wmi_bmof mtd snd_timer
> intel_uncore
> rfkill i2c_i801 pcspkr snd mei i2c_smbus soundcore dca intel_pch_thermal acpi_pa
> d acpi_tad joydev mousedev mac_hid wireguard curve25519_x86_64
> libchacha20poly130
> 5 chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha pppoe
> pppox ppp_g
> eneric slhc nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> [ 3790.612905]  dm_multipath coretemp gfs2 nfsd dlm auth_rpcgss
> nfs_acl sctp lock
> d grace ip6_udp_tunnel udp_tunnel libcrc32c sg sunrpc crypto_user fuse
> loop ip_ta
> bles x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid i915
> dm_mod raid1 i2c
> _algo_bit drm_buddy ttm md_mod nvme intel_gtt nvme_core crc32c_intel
> drm_display_
> helper spi_intel_pci spi_intel xhci_pci nvme_common cec
> xhci_pci_renesas video wm
> i
> [ 3790.612928] CPU: 6 PID: 38886 Comm: sudo Tainted: G             L
>    6.5.3-ar
> ch1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3790.612931] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3790.612932] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3790.612937] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3790.612939] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3790.612940] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3790.612942] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3790.612943] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3790.612945] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3790.612946] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3790.612947] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3790.612949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3790.612950] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3790.612951] Call Trace:
> [ 3790.612953]  <IRQ>
> [ 3790.612954]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3790.612958]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3790.612960]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3790.612963]  ? hrtimer_interrupt+0xf8/0x230
> [ 3790.612966]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3790.612968]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3790.612971]  </IRQ>
> [ 3790.612972]  <TASK>
> [ 3790.612973]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3790.612976]  ? __pfx_audit_cb+0x10/0x10
> [ 3790.612979]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3790.612982]  _raw_spin_lock+0x29/0x30
> [ 3790.612984]  get_task_exe_file+0x1f/0x70
> [ 3790.612988]  audit_exe_compare+0x15/0x60
> [ 3790.612991]  audit_filter+0x161/0x270
> [ 3790.612993]  ? __pfx_audit_cb+0x10/0x10
> [ 3790.612994]  audit_log_start+0x64/0x3c0
> [ 3790.612997]  ? __pfx_audit_pre+0x10/0x10
> [ 3790.612999]  ? __pfx_audit_cb+0x10/0x10
> [ 3790.613001]  common_lsm_audit+0x5f/0x910
> [ 3790.613003]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3790.613006]  aa_audit+0x5d/0x180
> [ 3790.613008]  aa_capable+0x1fd/0x400
> [ 3790.613011]  apparmor_capable+0xa5/0x190
> [ 3790.613014]  security_capable+0x41/0x70
> [ 3790.613017]  capable+0x2f/0x60
> [ 3790.613020]  do_prlimit+0x91/0x220
> [ 3790.613023]  __do_sys_prlimit64+0x22d/0x300
> [ 3790.613026]  do_syscall_64+0x5d/0x90
> [ 3790.613029]  ? audit_reset_context+0x232/0x300
> [ 3790.613031]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3790.613033]  ? do_syscall_64+0x6c/0x90
> [ 3790.613036]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3790.613038]  ? do_syscall_64+0x6c/0x90
> [ 3790.613040]  ? exc_page_fault+0x7f/0x180
> [ 3790.613042]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3790.613044] RIP: 0033:0x7f6be3905265
> [ 3790.613070] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3790.613072] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3790.613074] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3790.613075] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3790.613075] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3790.613076] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3790.613077] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3790.613079]  </TASK>
> [ 3796.886163] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 3796.886167] rcu:     6-....: (18000 ticks this GP)
> idle=1704/1/0x4000000000000
> 000 softirq=108610/108610 fqs=5925
> [ 3796.886171] rcu:     (t=18001 jiffies g=350457 q=24426 ncpus=8)
> [ 3796.886173] CPU: 6 PID: 38886 Comm: sudo Tainted: G             L
>    6.5.3-ar
> ch1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3796.886176] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3796.886177] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3796.886182] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3796.886184] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3796.886186] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3796.886187] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3796.886188] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3796.886189] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3796.886189] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3796.886191] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3796.886192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3796.886193] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3796.886194] Call Trace:
> [ 3796.886195]  <IRQ>
> [ 3796.886197]  ? rcu_dump_cpu_stacks+0xc4/0x100
> [ 3796.886201]  ? rcu_sched_clock_irq+0x4f2/0x1160
> [ 3796.886203]  ? task_tick_fair+0x370/0x500
> [ 3796.886206]  ? trigger_load_balance+0x73/0x390
> [ 3796.886209]  ? update_process_times+0x74/0xb0
> [ 3796.886211]  ? tick_sched_handle+0x21/0x60
> [ 3796.886213]  ? tick_sched_timer+0x6f/0x90
> [ 3796.886215]  ? __pfx_tick_sched_timer+0x10/0x10
> [ 3796.886218]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3796.886220]  ? hrtimer_interrupt+0xf8/0x230
> [ 3796.886223]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3796.886226]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3796.886228]  </IRQ>
> [ 3796.886229]  <TASK>
> [ 3796.886230]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3796.886233]  ? __pfx_audit_cb+0x10/0x10
> [ 3796.886236]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3796.886239]  _raw_spin_lock+0x29/0x30
> [ 3796.886241]  get_task_exe_file+0x1f/0x70
> [ 3796.886245]  audit_exe_compare+0x15/0x60
> [ 3796.886247]  audit_filter+0x161/0x270
> [ 3796.886249]  ? __pfx_audit_cb+0x10/0x10
> [ 3796.886251]  audit_log_start+0x64/0x3c0
> [ 3796.886254]  ? __pfx_audit_pre+0x10/0x10
> [ 3796.886256]  ? __pfx_audit_cb+0x10/0x10
> [ 3796.886258]  common_lsm_audit+0x5f/0x910
> [ 3796.886260]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3796.886263]  aa_audit+0x5d/0x180
> [ 3796.886265]  aa_capable+0x1fd/0x400
> [ 3796.886268]  apparmor_capable+0xa5/0x190
> [ 3796.886271]  security_capable+0x41/0x70
> [ 3796.886274]  capable+0x2f/0x60
> [ 3796.886276]  do_prlimit+0x91/0x220
> [ 3796.886279]  __do_sys_prlimit64+0x22d/0x300
> [ 3796.886282]  do_syscall_64+0x5d/0x90
> [ 3796.886285]  ? audit_reset_context+0x232/0x300
> [ 3796.886287]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3796.886289]  ? do_syscall_64+0x6c/0x90
> [ 3796.886292]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3796.886294]  ? do_syscall_64+0x6c/0x90
> [ 3796.886296]  ? exc_page_fault+0x7f/0x180
> [ 3796.886299]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3796.886301] RIP: 0033:0x7f6be3905265
> [ 3796.886325] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3796.886326] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3796.886328] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3796.886329] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3796.886330] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3796.886331] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3796.886332] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3796.886334]  </TASK>
> [ 3798.612640] watchdog: BUG: soft lockup - CPU#4 stuck for 48s! [ps:38979]
> [ 3798.612645] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> xt_tcpudp nft_compat sit tunnel4 ip_tunnel bridge nft_chain_nat nf_nat 8021q gar
> p mrp stp nf_tables llc nfnetlink snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence
> snd_sof_intel_hda snd_s
> of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
> soundwire_generic_allocation soun
> dwire_bus snd_soc_skl intel_rapl_msr intel_rapl_common
> intel_tcc_cooling snd_soc_
> hdac_hda snd_hda_ext_core vfat fat x86_pkg_temp_thermal
> [ 3798.612689]  intel_powerclamp snd_soc_sst_ipc snd_soc_sst_dsp
> kvm_intel snd_so
> c_acpi_intel_match snd_soc_acpi kvm snd_hda_codec_hdmi irqbypass
> snd_soc_core snd
> _hda_codec_realtek iwlmvm crct10dif_pclmul crc32_pclmul
> snd_hda_codec_generic snd
> _compress polyval_clmulni ledtrig_audio polyval_generic ac97_bus
> mac80211 snd_pcm
> _dmaengine gf128mul ghash_clmulni_intel sha512_ssse3 snd_hda_intel libarc4 btusb
> aesni_intel snd_intel_dspcfg mei_pxp mei_hdcp ee1004 crypto_simd btrtl
> iTCO_wdt i
> ntel_pmc_bxt btbcm snd_intel_sdw_acpi cryptd iTCO_vendor_support btintel iwlwifi
> snd_hda_codec rapl btmtk snd_hda_core intel_cstate bluetooth spi_nor
> cfg80211 snd
> _hwdep snd_pcm mei_me igb ecdh_generic e1000e wmi_bmof mtd snd_timer
> intel_uncore
> rfkill i2c_i801 pcspkr snd mei i2c_smbus soundcore dca intel_pch_thermal acpi_pa
> d acpi_tad joydev mousedev mac_hid wireguard curve25519_x86_64
> libchacha20poly130
> 5 chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha pppoe
> pppox ppp_g
> eneric slhc nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> [ 3798.612733]  dm_multipath coretemp gfs2 nfsd dlm auth_rpcgss
> nfs_acl sctp lock
> d grace ip6_udp_tunnel udp_tunnel libcrc32c sg sunrpc crypto_user fuse
> loop ip_ta
> bles x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid i915
> dm_mod raid1 i2c
> _algo_bit drm_buddy ttm md_mod nvme intel_gtt nvme_core crc32c_intel
> drm_display_
> helper spi_intel_pci spi_intel xhci_pci nvme_common cec
> xhci_pci_renesas video wm
> i
> [ 3798.612756] CPU: 4 PID: 38979 Comm: ps Tainted: G             L
> 6.5.3-arch
> 1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3798.612759] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3798.612761] RIP: 0010:native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3798.612766] Code: c5 01 41 c1 e4 10 41 c1 e5 12 45 09 ec 44 89 e0 c1 e8 10 66
> 87 43 02 89 c2 c1 e2 10 81 fa ff ff 00 00 77 5e 31 d2 eb 02 f3 90 <8b>
> 03 66 85 c
> 0 75 f7 44 39 e0 0f 84 8e 00 00 00 c6 03 01 48 85 d2
> [ 3798.612767] RSP: 0018:ffffb19a85643dc0 EFLAGS: 00000202
> [ 3798.612769] RAX: 0000000000140101 RBX: ffff8dede1760900 RCX: 0000000000000001
> [ 3798.612770] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8dede1760900
> [ 3798.612771] RBP: ffff8df4c2734dc0 R08: ffff8ded812f69d0 R09: 0000000000000000
> [ 3798.612772] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
> [ 3798.612773] R13: 0000000000140000 R14: ffffb19a85643ea0 R15: ffffffffa1250c60
> [ 3798.612774] FS:  00007f3cf6e644c0(0000) GS:ffff8df4c2700000(0000)
> knlGS:000000
> 0000000000
> [ 3798.612775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3798.612777] CR2: 00007f3cf63ff000 CR3: 00000001c41c4002 CR4: 00000000003706e0
> [ 3798.612778] Call Trace:
> [ 3798.612779]  <IRQ>
> [ 3798.612780]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3798.612784]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3798.612786]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3798.612789]  ? hrtimer_interrupt+0xf8/0x230
> [ 3798.612792]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3798.612795]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3798.612798]  </IRQ>
> [ 3798.612798]  <TASK>
> [ 3798.612799]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3798.612805]  ? native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3798.612808]  _raw_spin_lock+0x29/0x30
> [ 3798.612810]  ptrace_may_access+0x21/0x50
> [ 3798.612813]  proc_pid_readdir+0x8e/0x220
> [ 3798.612816]  iterate_dir+0x90/0x170
> [ 3798.612819]  __x64_sys_getdents64+0x88/0x130
> [ 3798.612822]  ? __pfx_filldir64+0x10/0x10
> [ 3798.612825]  do_syscall_64+0x5d/0x90
> [ 3798.612827]  ? exc_page_fault+0x7f/0x180
> [ 3798.612830]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3798.612832] RIP: 0033:0x7f3cf6cd63b7
> [ 3798.612857] Code: 33 fb ff 48 83 c4 08 48 89 e8 5b 5d c3 66 0f 1f 44 00 00 f3
> 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48>
> 3d 00 f0 f
> f ff 77 01 c3 48 8b 15 49 79 16 00 f7 d8 64 89 02 48
> [ 3798.612858] RSP: 002b:00007ffecbf3a018 EFLAGS: 00000293 ORIG_RAX:
> 000000000000
> 00d9
> [ 3798.612860] RAX: ffffffffffffffda RBX: 000055d96db4a2b0 RCX: 00007f3cf6cd63b7
> [ 3798.612861] RDX: 0000000000008000 RSI: 000055d96db4a2e0 RDI: 0000000000000003
> [ 3798.612862] RBP: 000055d96db4a2b4 R08: 000055d96db302d8 R09: ffffffffffffc000
> [ 3798.612862] R10: 00007f3cf636b030 R11: 0000000000000293 R12: 000055d96db4a2e0
> [ 3798.612863] R13: fffffffffffff2d8 R14: 0000000000000000 R15: 00000000ffffffff
> [ 3798.612866]  </TASK>
> [ 3798.859501] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> 6-.... } 18461 jiffies s: 16421 root: 0x40/.
> [ 3798.859507] rcu: blocking rcu_node structures (internal RCU debug):
> [ 3798.859508] Sending NMI from CPU 7 to CPUs 6:
> [ 3798.859512] NMI backtrace for cpu 6
> [ 3798.859513] CPU: 6 PID: 38886 Comm: sudo Tainted: G             L
>    6.5.3-ar
> ch1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3798.859516] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3798.859516] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3798.859522] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3798.859523] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3798.859524] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3798.859525] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3798.859526] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3798.859527] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3798.859527] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3798.859528] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3798.859529] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3798.859530] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3798.859531] Call Trace:
> [ 3798.859532]  <NMI>
> [ 3798.859533]  ? nmi_cpu_backtrace+0x99/0x110
> [ 3798.859536]  ? nmi_cpu_backtrace_handler+0x11/0x20
> [ 3798.859539]  ? nmi_handle+0x5e/0x150
> [ 3798.859541]  ? default_do_nmi+0x40/0x100
> [ 3798.859543]  ? exc_nmi+0x139/0x1c0
> [ 3798.859545]  ? end_repeat_nmi+0x16/0x67
> [ 3798.859548]  ? __pfx_audit_cb+0x10/0x10
> [ 3798.859551]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3798.859553]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3798.859555]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3798.859557]  </NMI>
> [ 3798.859557]  <TASK>
> [ 3798.859558]  _raw_spin_lock+0x29/0x30
> [ 3798.859560]  get_task_exe_file+0x1f/0x70
> [ 3798.859563]  audit_exe_compare+0x15/0x60
> [ 3798.859567]  audit_filter+0x161/0x270
> [ 3798.859568]  ? __pfx_audit_cb+0x10/0x10
> [ 3798.859570]  audit_log_start+0x64/0x3c0
> [ 3798.859573]  ? __pfx_audit_pre+0x10/0x10
> [ 3798.859574]  ? __pfx_audit_cb+0x10/0x10
> [ 3798.859576]  common_lsm_audit+0x5f/0x910
> [ 3798.859578]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3798.859581]  aa_audit+0x5d/0x180
> [ 3798.859583]  aa_capable+0x1fd/0x400
> [ 3798.859587]  apparmor_capable+0xa5/0x190
> [ 3798.859591]  security_capable+0x41/0x70
> [ 3798.859593]  capable+0x2f/0x60
> [ 3798.859595]  do_prlimit+0x91/0x220
> [ 3798.859598]  __do_sys_prlimit64+0x22d/0x300
> [ 3798.859602]  do_syscall_64+0x5d/0x90
> [ 3798.859604]  ? audit_reset_context+0x232/0x300
> [ 3798.859606]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3798.859609]  ? do_syscall_64+0x6c/0x90
> [ 3798.859610]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3798.859613]  ? do_syscall_64+0x6c/0x90
> [ 3798.859614]  ? exc_page_fault+0x7f/0x180
> [ 3798.859617]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3798.859619] RIP: 0033:0x7f6be3905265
> [ 3798.859640] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3798.859641] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3798.859642] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3798.859643] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3798.859644] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3798.859645] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3798.859645] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3798.859647]  </TASK>
> [ 3826.612128] watchdog: BUG: soft lockup - CPU#4 stuck for 74s! [ps:38979]
> [ 3826.612133] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> [ 3826.612158] watchdog: BUG: soft lockup - CPU#6 stuck for 85s! [sudo:38886]
> [ 3826.612159]  xt_tcpudp nft_compat sit tunnel4 ip_tunnel
> [ 3826.612162] Modules linked in:
> [ 3826.612162]  bridge
> [ 3826.612162]  netlink_diag
> [ 3826.612164]  nft_chain_nat
> [ 3826.612164]  xt_NETMAP dm_crypt
> [ 3826.612164]  nf_nat 8021q
> [ 3826.612165]  cbc encrypted_keys
> [ 3826.612166]  garp mrp
> [ 3826.612167]  trusted asn1_encoder
> [ 3826.612168]  stp nf_tables
> [ 3826.612168]  tee scsi_dh_alua
> [ 3826.612169]  llc nfnetlink
> [ 3826.612170]  dm_round_robin rpcrdma
> [ 3826.612171]  snd_sof_pci_intel_cnl
> [ 3826.612171]  rdma_cm
> [ 3826.612171]  snd_sof_intel_hda_common soundwire_intel
> [ 3826.612173]  iw_cm ib_cm
> [ 3826.612173]  snd_sof_intel_hda_mlink soundwire_cadence
> [ 3826.612174]  ib_core iscsi_tcp
> [ 3826.612175]  snd_sof_intel_hda
> [ 3826.612176]  libiscsi_tcp libiscsi
> [ 3826.612176]  snd_sof_pci snd_sof_xtensa_dsp
> [ 3826.612177]  cls_u32
> [ 3826.612178]  snd_sof
> [ 3826.612178]  sch_codel scsi_transport_iscsi sch_prio
> [ 3826.612179]  snd_sof_utils soundwire_generic_allocation
> [ 3826.612180]  xt_connmark xt_sctp
> [ 3826.612181]  soundwire_bus snd_soc_skl
> [ 3826.612182]  xt_NFQUEUE ts_bm
> [ 3826.612182]  intel_rapl_msr
> [ 3826.612183]  xt_string
> [ 3826.612183]  intel_rapl_common intel_tcc_cooling
> [ 3826.612184]  ip6t_REJECT nf_reject_ipv6
> [ 3826.612185]  snd_soc_hdac_hda snd_hda_ext_core
> [ 3826.612186]  ip6t_rpfilter pps_ldisc xt_mac
> [ 3826.612187]  vfat fat
> [ 3826.612188]  xt_conntrack xt_policy
> [ 3826.612189]  x86_pkg_temp_thermal intel_powerclamp
> [ 3826.612189]  veth nfnetlink_queue
> [ 3826.612190]  snd_soc_sst_ipc snd_soc_sst_dsp
> [ 3826.612191]  xt_TPROXY nf_tproxy_ipv6
> [ 3826.612192]  kvm_intel snd_soc_acpi_intel_match
> [ 3826.612193]  nf_tproxy_ipv4 xt_DSCP
> [ 3826.612194]  snd_soc_acpi kvm
> [ 3826.612194]  xt_dscp xt_HL
> [ 3826.612195]  snd_hda_codec_hdmi
> [ 3826.612196]  xt_hl
> [ 3826.612196]  irqbypass snd_soc_core
> [ 3826.612197]  xt_mark xt_MASQUERADE
> [ 3826.612197]  snd_hda_codec_realtek iwlmvm
> [ 3826.612198]  xt_nat xt_REDIRECT
> [ 3826.612199]  crct10dif_pclmul crc32_pclmul
> [ 3826.612200]  xt_cgroup xt_recent
> [ 3826.612201]  snd_hda_codec_generic
> [ 3826.612201]  ipt_REJECT
> [ 3826.612201]  snd_compress
> [ 3826.612202]  nf_reject_ipv4 xt_TCPMSS
> [ 3826.612203]  polyval_clmulni ledtrig_audio
> [ 3826.612203]  xt_tcpudp nft_compat
> [ 3826.612204]  polyval_generic
> [ 3826.612205]  sit
> [ 3826.612205]  ac97_bus mac80211
> [ 3826.612206]  tunnel4 ip_tunnel
> [ 3826.612207]  snd_pcm_dmaengine gf128mul
> [ 3826.612207]  bridge nft_chain_nat
> [ 3826.612208]  ghash_clmulni_intel sha512_ssse3
> [ 3826.612209]  nf_nat 8021q
> [ 3826.612210]  snd_hda_intel
> [ 3826.612210]  garp
> [ 3826.612210]  libarc4 btusb
> [ 3826.612211]  mrp stp
> [ 3826.612212]  aesni_intel snd_intel_dspcfg
> [ 3826.612213]  nf_tables llc
> [ 3826.612214]  mei_pxp
> [ 3826.612214]  nfnetlink snd_sof_pci_intel_cnl
> [ 3826.612215]  mei_hdcp ee1004
> [ 3826.612215]  snd_sof_intel_hda_common soundwire_intel
> [ 3826.612216]  crypto_simd btrtl
> [ 3826.612217]  snd_sof_intel_hda_mlink soundwire_cadence
> [ 3826.612218]  iTCO_wdt intel_pmc_bxt
> [ 3826.612218]  snd_sof_intel_hda snd_sof_pci
> [ 3826.612219]  btbcm snd_intel_sdw_acpi
> [ 3826.612220]  snd_sof_xtensa_dsp snd_sof
> [ 3826.612221]  cryptd iTCO_vendor_support
> [ 3826.612221]  snd_sof_utils soundwire_generic_allocation
> [ 3826.612222]  btintel iwlwifi
> [ 3826.612223]  soundwire_bus snd_soc_skl
> [ 3826.612224]  snd_hda_codec rapl
> [ 3826.612224]  intel_rapl_msr intel_rapl_common
> [ 3826.612225]  btmtk
> [ 3826.612226]  intel_tcc_cooling
> [ 3826.612226]  snd_hda_core intel_cstate
> [ 3826.612227]  snd_soc_hdac_hda snd_hda_ext_core
> [ 3826.612228]  bluetooth
> [ 3826.612228]  vfat
> [ 3826.612228]  spi_nor cfg80211
> [ 3826.612229]  fat x86_pkg_temp_thermal
> [ 3826.612230]  snd_hwdep
> [ 3826.612231]  intel_powerclamp
> [ 3826.612231]  snd_pcm mei_me
> [ 3826.612232]  snd_soc_sst_ipc
> [ 3826.612232]  igb ecdh_generic
> [ 3826.612233]  snd_soc_sst_dsp kvm_intel
> [ 3826.612234]  e1000e wmi_bmof
> [ 3826.612234]  snd_soc_acpi_intel_match snd_soc_acpi
> [ 3826.612235]  mtd snd_timer
> [ 3826.612236]  kvm snd_hda_codec_hdmi
> [ 3826.612237]  intel_uncore rfkill
> [ 3826.612238]  irqbypass snd_soc_core
> [ 3826.612238]  i2c_i801 pcspkr
> [ 3826.612239]  snd_hda_codec_realtek iwlmvm
> [ 3826.612240]  snd mei
> [ 3826.612241]  crct10dif_pclmul crc32_pclmul
> [ 3826.612242]  i2c_smbus
> [ 3826.612242]  snd_hda_codec_generic snd_compress
> [ 3826.612243]  soundcore dca
> [ 3826.612243]  polyval_clmulni ledtrig_audio
> [ 3826.612244]  intel_pch_thermal acpi_pad
> [ 3826.612245]  polyval_generic ac97_bus
> [ 3826.612246]  acpi_tad joydev
> [ 3826.612246]  mac80211 snd_pcm_dmaengine
> [ 3826.612247]  mousedev mac_hid
> [ 3826.612248]  gf128mul ghash_clmulni_intel
> [ 3826.612249]  wireguard
> [ 3826.612249]  sha512_ssse3
> [ 3826.612250]  curve25519_x86_64 libchacha20poly1305
> [ 3826.612250]  snd_hda_intel libarc4
> [ 3826.612251]  chacha_x86_64
> [ 3826.612252]  btusb
> [ 3826.612252]  poly1305_x86_64 libcurve25519_generic
> [ 3826.612253]  aesni_intel snd_intel_dspcfg
> [ 3826.612254]  libchacha pppoe
> [ 3826.612254]  mei_pxp
> [ 3826.612255]  pppox ppp_generic
> [ 3826.612255]  mei_hdcp ee1004
> [ 3826.612256]  slhc
> [ 3826.612257]  crypto_simd
> [ 3826.612257]  nf_conntrack
> [ 3826.612257]  btrtl iTCO_wdt
> [ 3826.612258]  nf_defrag_ipv6 nf_defrag_ipv4
> [ 3826.612259]  intel_pmc_bxt btbcm
> [ 3826.612260]  dm_multipath coretemp
> [ 3826.612261]  snd_intel_sdw_acpi cryptd
> [ 3826.612261]  gfs2 nfsd
> [ 3826.612262]  iTCO_vendor_support btintel
> [ 3826.612263]  dlm auth_rpcgss
> [ 3826.612264]  iwlwifi snd_hda_codec
> [ 3826.612264]  nfs_acl
> [ 3826.612265]  rapl
> [ 3826.612265]  sctp lockd
> [ 3826.612266]  btmtk
> [ 3826.612267]  grace ip6_udp_tunnel
> [ 3826.612267]  snd_hda_core intel_cstate
> [ 3826.612268]  udp_tunnel libcrc32c
> [ 3826.612269]  bluetooth spi_nor
> [ 3826.612270]  sg sunrpc
> [ 3826.612270]  cfg80211 snd_hwdep
> [ 3826.612271]  crypto_user fuse
> [ 3826.612272]  snd_pcm mei_me
> [ 3826.612273]  loop
> [ 3826.612273]  igb ecdh_generic
> [ 3826.612274]  ip_tables x_tables
> [ 3826.612275]  e1000e wmi_bmof
> [ 3826.612276]  ext4 crc32c_generic
> [ 3826.612276]  mtd snd_timer
> [ 3826.612277]  crc16 mbcache
> [ 3826.612278]  intel_uncore rfkill
> [ 3826.612279]  jbd2 usbhid
> [ 3826.612280]  i2c_i801 pcspkr snd
> [ 3826.612281]  i915 dm_mod
> [ 3826.612282]  mei i2c_smbus
> [ 3826.612283]  raid1 i2c_algo_bit
> [ 3826.612283]  soundcore dca
> [ 3826.612284]  drm_buddy ttm
> [ 3826.612285]  intel_pch_thermal acpi_pad
> [ 3826.612287]  md_mod nvme
> [ 3826.612287]  acpi_tad joydev
> [ 3826.612289]  intel_gtt
> [ 3826.612289]  mousedev mac_hid
> [ 3826.612290]  nvme_core crc32c_intel
> [ 3826.612291]  wireguard curve25519_x86_64
> [ 3826.612291]  drm_display_helper spi_intel_pci
> [ 3826.612292]  libchacha20poly1305 chacha_x86_64
> [ 3826.612293]  spi_intel xhci_pci
> [ 3826.612294]  poly1305_x86_64 libcurve25519_generic
> [ 3826.612294]  nvme_common cec
> [ 3826.612295]  libchacha pppoe pppox
> [ 3826.612296]  xhci_pci_renesas video
> [ 3826.612297]  ppp_generic slhc
> [ 3826.612298]  wmi
> [ 3826.612299]  nf_conntrack
> 
> [ 3826.612300]  nf_defrag_ipv6 nf_defrag_ipv4 dm_multipath coretemp
> [ 3826.612300] CPU: 4 PID: 38979 Comm: ps Tainted: G             L
> 6.5.3-arch
> 1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3826.612301]  gfs2 nfsd dlm
> [ 3826.612303] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3826.612303]  auth_rpcgss nfs_acl sctp lockd grace ip6_udp_tunnel
> udp_tunnel li
> bcrc32c sg sunrpc
> [ 3826.612305] RIP: 0010:native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3826.612308]  crypto_user fuse loop ip_tables
> [ 3826.612310] Code: c5 01 41 c1 e4 10 41 c1 e5 12 45 09 ec 44 89 e0 c1 e8 10 66
> 87 43 02 89 c2 c1 e2 10 81 fa ff ff 00 00 77 5e 31 d2 eb 02 f3 90 <8b>
> 03 66 85 c
> 0 75 f7 44 39 e0 0f 84 8e 00 00 00 c6 03 01 48 85 d2
> [ 3826.612310]  x_tables ext4 crc32c_generic crc16
> [ 3826.612312] RSP: 0018:ffffb19a85643dc0 EFLAGS: 00000202
> [ 3826.612313]  mbcache jbd2
> 
> [ 3826.612315]  usbhid
> [ 3826.612314] RAX: 0000000000140101 RBX: ffff8dede1760900 RCX: 0000000000000001
> [ 3826.612315]  i915 dm_mod
> [ 3826.612316] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8dede1760900
> [ 3826.612316]  raid1
> [ 3826.612317] RBP: ffff8df4c2734dc0 R08: ffff8ded812f69d0 R09: 0000000000000000
> [ 3826.612317]  i2c_algo_bit
> [ 3826.612318] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
> [ 3826.612318]  drm_buddy
> [ 3826.612319] R13: 0000000000140000 R14: ffffb19a85643ea0 R15: ffffffffa1250c60
> [ 3826.612320]  ttm md_mod
> [ 3826.612321] FS:  00007f3cf6e644c0(0000) GS:ffff8df4c2700000(0000)
> knlGS:000000
> 0000000000
> [ 3826.612321]  nvme intel_gtt nvme_core
> [ 3826.612322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3826.612323]  crc32c_intel drm_display_helper
> [ 3826.612324] CR2: 00007f3cf63ff000 CR3: 00000001c41c4002 CR4: 00000000003706e0
> [ 3826.612324]  spi_intel_pci spi_intel
> [ 3826.612326] Call Trace:
> [ 3826.612326]  xhci_pci nvme_common cec xhci_pci_renesas
> [ 3826.612327]  <IRQ>
> [ 3826.612329]  video wmi
> [ 3826.612329]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3826.612330] CPU: 6 PID: 38886 Comm: sudo Tainted: G             L
>    6.5.3-ar
> ch1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3826.612333] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3826.612333]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3826.612334] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3826.612335]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3826.612338] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3826.612339]  ? hrtimer_interrupt+0xf8/0x230
> [ 3826.612340] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3826.612342] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3826.612341]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3826.612343] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3826.612344] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3826.612345] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3826.612346] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3826.612345]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3826.612347] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3826.612348]  </IRQ>
> [ 3826.612348]  <TASK>
> [ 3826.612349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3826.612349]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3826.612350] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3826.612352] Call Trace:
> [ 3826.612353]  <IRQ>
> [ 3826.612353]  ? native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3826.612354]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3826.612356]  _raw_spin_lock+0x29/0x30
> [ 3826.612357]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3826.612358]  ptrace_may_access+0x21/0x50
> [ 3826.612360]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3826.612362]  proc_pid_readdir+0x8e/0x220
> [ 3826.612363]  ? hrtimer_interrupt+0xf8/0x230
> [ 3826.612365]  iterate_dir+0x90/0x170
> [ 3826.612366]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3826.612368]  __x64_sys_getdents64+0x88/0x130
> [ 3826.612368]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3826.612371]  </IRQ>
> [ 3826.612371]  <TASK>
> [ 3826.612371]  ? __pfx_filldir64+0x10/0x10
> [ 3826.612372]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3826.612374]  do_syscall_64+0x5d/0x90
> [ 3826.612375]  ? __pfx_audit_cb+0x10/0x10
> [ 3826.612377]  ? exc_page_fault+0x7f/0x180
> [ 3826.612378]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3826.612380]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3826.612381]  _raw_spin_lock+0x29/0x30
> [ 3826.612384]  get_task_exe_file+0x1f/0x70
> [ 3826.612387]  audit_exe_compare+0x15/0x60
> [ 3826.612390]  audit_filter+0x161/0x270
> [ 3826.612392]  ? __pfx_audit_cb+0x10/0x10
> [ 3826.612393]  audit_log_start+0x64/0x3c0
> [ 3826.612396]  ? __pfx_audit_pre+0x10/0x10
> [ 3826.612398]  ? __pfx_audit_cb+0x10/0x10
> [ 3826.612400]  common_lsm_audit+0x5f/0x910
> [ 3826.612382] RIP: 0033:0x7f3cf6cd63b7
> [ 3826.612402]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3826.612405]  aa_audit+0x5d/0x180
> [ 3826.612407] Code: 33 fb ff 48 83 c4 08 48 89 e8 5b 5d c3 66 0f 1f 44 00 00 f3
> 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48>
> 3d 00 f0 f
> f ff 77 01 c3 48 8b 15 49 79 16 00 f7 d8 64 89 02 48
> [ 3826.612408]  aa_capable+0x1fd/0x400
> [ 3826.612408] RSP: 002b:00007ffecbf3a018 EFLAGS: 00000293 ORIG_RAX:
> 000000000000
> 00d9
> [ 3826.612410] RAX: ffffffffffffffda RBX: 000055d96db4a2b0 RCX: 00007f3cf6cd63b7
> [ 3826.612411] RDX: 0000000000008000 RSI: 000055d96db4a2e0 RDI: 0000000000000003
> [ 3826.612411]  apparmor_capable+0xa5/0x190
> [ 3826.612412] RBP: 000055d96db4a2b4 R08: 000055d96db302d8 R09: ffffffffffffc000
> [ 3826.612413] R10: 00007f3cf636b030 R11: 0000000000000293 R12: 000055d96db4a2e0
> [ 3826.612414] R13: fffffffffffff2d8 R14: 0000000000000000 R15: 00000000ffffffff
> [ 3826.612415]  security_capable+0x41/0x70
> [ 3826.612417]  </TASK>
> [ 3826.612418]  capable+0x2f/0x60
> [ 3826.612420]  do_prlimit+0x91/0x220
> [ 3826.612423]  __do_sys_prlimit64+0x22d/0x300
> [ 3826.612426]  do_syscall_64+0x5d/0x90
> [ 3826.612429]  ? audit_reset_context+0x232/0x300
> [ 3826.612431]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3826.612433]  ? do_syscall_64+0x6c/0x90
> [ 3826.612435]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3826.612438]  ? do_syscall_64+0x6c/0x90
> [ 3826.612440]  ? exc_page_fault+0x7f/0x180
> [ 3826.612443]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3826.612445] RIP: 0033:0x7f6be3905265
> [ 3826.612458] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3826.612459] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3826.612461] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3826.612462] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3826.612463] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3826.612464] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3826.612465] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3826.612467]  </TASK>
> [ 3854.611615] watchdog: BUG: soft lockup - CPU#4 stuck for 100s! [ps:38979]
> [ 3854.611620] Modules linked in: netlink_diag xt_NETMAP dm_crypt cbc
> encrypted_k
> eys trusted asn1_encoder tee scsi_dh_alua dm_round_robin rpcrdma
> rdma_cm iw_cm ib
> _cm ib_core iscsi_tcp libiscsi_tcp libiscsi cls_u32 sch_codel
> scsi_transport_iscs
> i sch_prio xt_connmark xt_sctp xt_NFQUEUE ts_bm xt_string ip6t_REJECT
> nf_reject_i
> pv6 ip6t_rpfilter pps_ldisc xt_mac xt_conntrack xt_policy veth
> nfnetlink_queue xt
> _TPROXY nf_tproxy_ipv6 nf_tproxy_ipv4 xt_DSCP xt_dscp xt_HL xt_hl
> xt_mark xt_MASQ
> UERADE xt_nat xt_REDIRECT xt_cgroup xt_recent ipt_REJECT
> nf_reject_ipv4 xt_TCPMSS
> [ 3854.611646] watchdog: BUG: soft lockup - CPU#6 stuck for 111s! [sudo:38886]
> [ 3854.611647]  xt_tcpudp nft_compat sit tunnel4 ip_tunnel
> [ 3854.611650] Modules linked in:
> [ 3854.611650]  bridge nft_chain_nat nf_nat
> [ 3854.611651]  netlink_diag
> [ 3854.611653]  8021q
> [ 3854.611653]  xt_NETMAP
> [ 3854.611654]  garp
> [ 3854.611654]  dm_crypt
> [ 3854.611655]  mrp stp
> [ 3854.611656]  cbc
> [ 3854.611656]  nf_tables llc nfnetlink
> [ 3854.611657]  encrypted_keys trusted
> [ 3854.611658]  snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel
> [ 3854.611660]  asn1_encoder tee
> [ 3854.611661]  snd_sof_intel_hda_mlink soundwire_cadence
> [ 3854.611662]  scsi_dh_alua
> [ 3854.611662]  snd_sof_intel_hda snd_sof_pci
> [ 3854.611663]  dm_round_robin rpcrdma
> [ 3854.611664]  snd_sof_xtensa_dsp snd_sof
> [ 3854.611665]  rdma_cm iw_cm
> [ 3854.611666]  snd_sof_utils
> [ 3854.611666]  ib_cm
> [ 3854.611666]  soundwire_generic_allocation
> [ 3854.611667]  ib_core
> [ 3854.611667]  soundwire_bus snd_soc_skl
> [ 3854.611669]  iscsi_tcp libiscsi_tcp
> [ 3854.611669]  intel_rapl_msr intel_rapl_common
> [ 3854.611670]  libiscsi cls_u32
> [ 3854.611671]  intel_tcc_cooling snd_soc_hdac_hda
> [ 3854.611672]  sch_codel scsi_transport_iscsi
> [ 3854.611673]  snd_hda_ext_core
> [ 3854.611673]  sch_prio
> [ 3854.611673]  vfat fat
> [ 3854.611674]  xt_connmark xt_sctp xt_NFQUEUE ts_bm
> [ 3854.611676]  x86_pkg_temp_thermal intel_powerclamp
> [ 3854.611677]  xt_string ip6t_REJECT
> [ 3854.611678]  snd_soc_sst_ipc snd_soc_sst_dsp
> [ 3854.611678]  nf_reject_ipv6 ip6t_rpfilter
> [ 3854.611679]  kvm_intel
> [ 3854.611680]  pps_ldisc
> [ 3854.611680]  snd_soc_acpi_intel_match snd_soc_acpi
> [ 3854.611681]  xt_mac xt_conntrack
> [ 3854.611682]  kvm snd_hda_codec_hdmi
> [ 3854.611683]  xt_policy veth nfnetlink_queue
> [ 3854.611684]  irqbypass snd_soc_core
> [ 3854.611685]  xt_TPROXY
> [ 3854.611685]  snd_hda_codec_realtek
> [ 3854.611686]  nf_tproxy_ipv6 nf_tproxy_ipv4
> [ 3854.611687]  iwlmvm
> [ 3854.611687]  xt_DSCP xt_dscp
> [ 3854.611688]  crct10dif_pclmul
> [ 3854.611688]  xt_HL xt_hl
> [ 3854.611689]  crc32_pclmul
> [ 3854.611690]  xt_mark
> [ 3854.611690]  snd_hda_codec_generic snd_compress
> [ 3854.611691]  xt_MASQUERADE xt_nat
> [ 3854.611692]  polyval_clmulni
> [ 3854.611692]  xt_REDIRECT xt_cgroup
> [ 3854.611693]  ledtrig_audio
> [ 3854.611693]  xt_recent ipt_REJECT
> [ 3854.611694]  polyval_generic ac97_bus
> [ 3854.611695]  nf_reject_ipv4 xt_TCPMSS
> [ 3854.611696]  mac80211 snd_pcm_dmaengine
> [ 3854.611696]  xt_tcpudp nft_compat
> [ 3854.611697]  gf128mul ghash_clmulni_intel
> [ 3854.611698]  sit tunnel4
> [ 3854.611699]  sha512_ssse3
> [ 3854.611699]  ip_tunnel
> [ 3854.611700]  snd_hda_intel libarc4
> [ 3854.611700]  bridge nft_chain_nat
> [ 3854.611701]  btusb aesni_intel
> [ 3854.611702]  nf_nat 8021q
> [ 3854.611703]  snd_intel_dspcfg mei_pxp
> [ 3854.611703]  garp mrp
> [ 3854.611704]  mei_hdcp ee1004
> [ 3854.611705]  stp nf_tables
> [ 3854.611705]  crypto_simd btrtl
> [ 3854.611706]  llc nfnetlink
> [ 3854.611707]  iTCO_wdt
> [ 3854.611707]  snd_sof_pci_intel_cnl snd_sof_intel_hda_common
> [ 3854.611708]  intel_pmc_bxt btbcm
> [ 3854.611709]  soundwire_intel snd_sof_intel_hda_mlink
> [ 3854.611710]  snd_intel_sdw_acpi cryptd
> [ 3854.611711]  soundwire_cadence snd_sof_intel_hda
> [ 3854.611712]  iTCO_vendor_support btintel
> [ 3854.611712]  snd_sof_pci
> [ 3854.611713]  iwlwifi
> [ 3854.611713]  snd_sof_xtensa_dsp snd_sof
> [ 3854.611714]  snd_hda_codec
> [ 3854.611715]  snd_sof_utils
> [ 3854.611715]  rapl btmtk
> [ 3854.611716]  soundwire_generic_allocation
> [ 3854.611717]  snd_hda_core
> [ 3854.611717]  soundwire_bus snd_soc_skl
> [ 3854.611718]  intel_cstate bluetooth
> [ 3854.611719]  intel_rapl_msr intel_rapl_common
> [ 3854.611719]  spi_nor cfg80211
> [ 3854.611720]  intel_tcc_cooling snd_soc_hdac_hda
> [ 3854.611721]  snd_hwdep
> [ 3854.611722]  snd_hda_ext_core
> [ 3854.611722]  snd_pcm
> [ 3854.611723]  vfat
> [ 3854.611723]  mei_me igb
> [ 3854.611724]  fat x86_pkg_temp_thermal
> [ 3854.611724]  ecdh_generic e1000e
> [ 3854.611725]  intel_powerclamp snd_soc_sst_ipc
> [ 3854.611726]  wmi_bmof mtd
> [ 3854.611727]  snd_soc_sst_dsp kvm_intel
> [ 3854.611728]  snd_timer intel_uncore
> [ 3854.611728]  snd_soc_acpi_intel_match snd_soc_acpi
> [ 3854.611729]  rfkill i2c_i801
> [ 3854.611730]  kvm snd_hda_codec_hdmi
> [ 3854.611731]  pcspkr snd
> [ 3854.611731]  irqbypass snd_soc_core
> [ 3854.611732]  mei i2c_smbus
> [ 3854.611733]  snd_hda_codec_realtek iwlmvm
> [ 3854.611734]  soundcore dca
> [ 3854.611734]  crct10dif_pclmul crc32_pclmul
> [ 3854.611735]  intel_pch_thermal acpi_pad
> [ 3854.611736]  snd_hda_codec_generic snd_compress
> [ 3854.611737]  acpi_tad
> [ 3854.611737]  polyval_clmulni
> [ 3854.611738]  joydev
> [ 3854.611738]  ledtrig_audio
> [ 3854.611739]  mousedev mac_hid
> [ 3854.611739]  polyval_generic
> [ 3854.611740]  wireguard
> [ 3854.611740]  ac97_bus mac80211
> [ 3854.611741]  curve25519_x86_64 libchacha20poly1305
> [ 3854.611742]  snd_pcm_dmaengine gf128mul
> [ 3854.611743]  chacha_x86_64 poly1305_x86_64
> [ 3854.611744]  ghash_clmulni_intel sha512_ssse3
> [ 3854.611744]  libcurve25519_generic libchacha
> [ 3854.611745]  snd_hda_intel libarc4
> [ 3854.611746]  pppoe pppox
> [ 3854.611747]  btusb
> [ 3854.611748]  ppp_generic
> [ 3854.611748]  aesni_intel snd_intel_dspcfg
> [ 3854.611749]  slhc nf_conntrack
> [ 3854.611750]  mei_pxp mei_hdcp
> [ 3854.611750]  nf_defrag_ipv6 nf_defrag_ipv4
> [ 3854.611751]  ee1004 crypto_simd
> [ 3854.611752]  dm_multipath coretemp
> [ 3854.611753]  btrtl iTCO_wdt intel_pmc_bxt
> [ 3854.611754]  gfs2
> [ 3854.611755]  btbcm
> [ 3854.611755]  nfsd dlm
> [ 3854.611756]  snd_intel_sdw_acpi cryptd
> [ 3854.611757]  auth_rpcgss nfs_acl
> [ 3854.611758]  iTCO_vendor_support btintel
> [ 3854.611758]  sctp lockd
> [ 3854.611759]  iwlwifi
> [ 3854.611760]  grace
> [ 3854.611760]  snd_hda_codec rapl
> [ 3854.611761]  ip6_udp_tunnel
> [ 3854.611762]  btmtk
> [ 3854.611762]  udp_tunnel
> [ 3854.611762]  snd_hda_core intel_cstate
> [ 3854.611763]  libcrc32c sg
> [ 3854.611764]  bluetooth spi_nor
> [ 3854.611765]  sunrpc crypto_user
> [ 3854.611766]  cfg80211 snd_hwdep
> [ 3854.611766]  fuse loop
> [ 3854.611767]  snd_pcm mei_me
> [ 3854.611768]  ip_tables x_tables
> [ 3854.611769]  igb ecdh_generic
> [ 3854.611770]  ext4 crc32c_generic
> [ 3854.611771]  e1000e wmi_bmof mtd
> [ 3854.611773]  crc16
> [ 3854.611773]  snd_timer
> [ 3854.611774]  mbcache
> [ 3854.611774]  intel_uncore rfkill
> [ 3854.611775]  jbd2 usbhid
> [ 3854.611776]  i2c_i801
> [ 3854.611776]  i915
> [ 3854.611776]  pcspkr snd mei
> [ 3854.611778]  dm_mod raid1
> [ 3854.611778]  i2c_smbus soundcore
> [ 3854.611779]  i2c_algo_bit drm_buddy
> [ 3854.611780]  dca intel_pch_thermal
> [ 3854.611781]  ttm md_mod
> [ 3854.611781]  acpi_pad acpi_tad
> [ 3854.611782]  nvme intel_gtt
> [ 3854.611783]  joydev
> [ 3854.611784]  nvme_core
> [ 3854.611784]  mousedev mac_hid wireguard
> [ 3854.611785]  crc32c_intel drm_display_helper
> [ 3854.611786]  curve25519_x86_64 libchacha20poly1305
> [ 3854.611787]  spi_intel_pci spi_intel
> [ 3854.611788]  chacha_x86_64 poly1305_x86_64
> [ 3854.611789]  xhci_pci nvme_common
> [ 3854.611789]  libcurve25519_generic libchacha
> [ 3854.611790]  cec xhci_pci_renesas
> [ 3854.611791]  pppoe pppox
> [ 3854.611792]  video wmi
> [ 3854.611792]  ppp_generic slhc
> 
> [ 3854.611794]  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 dm_multipath coretemp
> [ 3854.611795] CPU: 4 PID: 38979 Comm: ps Tainted: G             L
> 6.5.3-arch
> 1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3854.611797]  gfs2 nfsd dlm
> [ 3854.611798] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3854.611798]  auth_rpcgss nfs_acl sctp lockd grace ip6_udp_tunnel
> udp_tunnel li
> bcrc32c sg sunrpc crypto_user
> [ 3854.611800] RIP: 0010:native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3854.611803]  fuse loop ip_tables x_tables ext4
> [ 3854.611806] Code: c5 01 41 c1 e4 10 41 c1 e5 12 45 09 ec 44 89 e0 c1 e8 10 66
> 87 43 02 89 c2 c1 e2 10 81 fa ff ff 00 00 77 5e 31 d2 eb 02 f3 90 <8b>
> 03 66 85 c
> 0 75 f7 44 39 e0 0f 84 8e 00 00 00 c6 03 01 48 85 d2
> [ 3854.611806]  crc32c_generic crc16 mbcache
> [ 3854.611807] RSP: 0018:ffffb19a85643dc0 EFLAGS: 00000202
> [ 3854.611808]  jbd2 usbhid
> 
> [ 3854.611810]  i915
> [ 3854.611810] RAX: 0000000000140101 RBX: ffff8dede1760900 RCX: 0000000000000001
> [ 3854.611811]  dm_mod raid1
> [ 3854.611811] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8dede1760900
> [ 3854.611812]  i2c_algo_bit drm_buddy
> [ 3854.611813] RBP: ffff8df4c2734dc0 R08: ffff8ded812f69d0 R09: 0000000000000000
> [ 3854.611814]  ttm md_mod
> [ 3854.611814] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
> [ 3854.611815]  nvme intel_gtt
> [ 3854.611816] R13: 0000000000140000 R14: ffffb19a85643ea0 R15: ffffffffa1250c60
> [ 3854.611817]  nvme_core crc32c_intel
> [ 3854.611818] FS:  00007f3cf6e644c0(0000) GS:ffff8df4c2700000(0000)
> knlGS:000000
> 0000000000
> [ 3854.611818]  drm_display_helper spi_intel_pci spi_intel
> [ 3854.611820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3854.611820]  xhci_pci nvme_common cec
> [ 3854.611821] CR2: 00007f3cf63ff000 CR3: 00000001c41c4002 CR4: 00000000003706e0
> [ 3854.611822]  xhci_pci_renesas video
> [ 3854.611823] Call Trace:
> [ 3854.611824]  wmi
> [ 3854.611825]  <IRQ>
> [ 3854.611825] CPU: 6 PID: 38886 Comm: sudo Tainted: G             L
>    6.5.3-ar
> ch1-1 #1 ed5b3b894d0aeb37298a77837232ca9b353cc27d
> [ 3854.611828] Hardware name: Shuttle Inc. DS20U/DS20U, BIOS 2.02 12/14/2021
> [ 3854.611827]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3854.611829] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3854.611831]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3854.611833] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f>
> b6 03 84 c
> 0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 b3 c2 e8
> [ 3854.611833]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3854.611835] RSP: 0018:ffffb19a855a3a48 EFLAGS: 00000202
> [ 3854.611836]  ? hrtimer_interrupt+0xf8/0x230
> [ 3854.611837] RAX: 0000000000000001 RBX: ffff8dede1760900 RCX: ffffffff9f94dde0
> [ 3854.611838] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dede1760900
> [ 3854.611840] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [ 3854.611840] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8dede1760900
> [ 3854.611840]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3854.611841] R13: ffff8deda5c13a00 R14: ffffffffa12e13b0 R15: 0000000000000000
> [ 3854.611843] FS:  00007f6be3b46740(0000) GS:ffff8df4c2780000(0000)
> knlGS:000000
> 0000000000
> [ 3854.611844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3854.611843]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3854.611846] CR2: 0000560f19d70c30 CR3: 00000001304ec004 CR4: 00000000003706e0
> [ 3854.611847]  </IRQ>
> [ 3854.611847] Call Trace:
> [ 3854.611848]  <TASK>
> [ 3854.611848]  <IRQ>
> [ 3854.611849]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3854.611850]  ? watchdog_timer_fn+0x1b8/0x220
> [ 3854.611853]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3854.611853]  ? native_queued_spin_lock_slowpath+0x223/0x2e0
> [ 3854.611856]  _raw_spin_lock+0x29/0x30
> [ 3854.611856]  ? __hrtimer_run_queues+0x10f/0x2b0
> [ 3854.611859]  ? hrtimer_interrupt+0xf8/0x230
> [ 3854.611858]  ptrace_may_access+0x21/0x50
> [ 3854.611861]  ? __sysvec_apic_timer_interrupt+0x5e/0x130
> [ 3854.611862]  proc_pid_readdir+0x8e/0x220
> [ 3854.611864]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [ 3854.611864]  iterate_dir+0x90/0x170
> [ 3854.611867]  </IRQ>
> [ 3854.611867]  <TASK>
> [ 3854.611868]  __x64_sys_getdents64+0x88/0x130
> [ 3854.611868]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [ 3854.611871]  ? __pfx_filldir64+0x10/0x10
> [ 3854.611871]  ? __pfx_audit_cb+0x10/0x10
> [ 3854.611874]  do_syscall_64+0x5d/0x90
> [ 3854.611875]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [ 3854.611877]  ? exc_page_fault+0x7f/0x180
> [ 3854.611878]  _raw_spin_lock+0x29/0x30
> [ 3854.611880]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3854.611880]  get_task_exe_file+0x1f/0x70
> [ 3854.611884]  audit_exe_compare+0x15/0x60
> [ 3854.611887]  audit_filter+0x161/0x270
> [ 3854.611889]  ? __pfx_audit_cb+0x10/0x10
> [ 3854.611891]  audit_log_start+0x64/0x3c0
> [ 3854.611894]  ? __pfx_audit_pre+0x10/0x10
> [ 3854.611895]  ? __pfx_audit_cb+0x10/0x10
> [ 3854.611897]  common_lsm_audit+0x5f/0x910
> [ 3854.611900]  ? get_page_from_freelist+0x1674/0x17d0
> [ 3854.611903]  aa_audit+0x5d/0x180
> [ 3854.611882] RIP: 0033:0x7f3cf6cd63b7
> [ 3854.611905]  aa_capable+0x1fd/0x400
> [ 3854.611908] Code: 33 fb ff 48 83 c4 08 48 89 e8 5b 5d c3 66 0f 1f 44 00 00 f3
> 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48>
> 3d 00 f0 f
> f ff 77 01 c3 48 8b 15 49 79 16 00 f7 d8 64 89 02 48
> [ 3854.611908]  apparmor_capable+0xa5/0x190
> [ 3854.611909] RSP: 002b:00007ffecbf3a018 EFLAGS: 00000293 ORIG_RAX:
> 000000000000
> 00d9
> [ 3854.611912] RAX: ffffffffffffffda RBX: 000055d96db4a2b0 RCX: 00007f3cf6cd63b7
> [ 3854.611911]  security_capable+0x41/0x70
> [ 3854.611913] RDX: 0000000000008000 RSI: 000055d96db4a2e0 RDI: 0000000000000003
> [ 3854.611914] RBP: 000055d96db4a2b4 R08: 000055d96db302d8 R09: ffffffffffffc000
> [ 3854.611915] R10: 00007f3cf636b030 R11: 0000000000000293 R12: 000055d96db4a2e0
> [ 3854.611914]  capable+0x2f/0x60
> [ 3854.611916] R13: fffffffffffff2d8 R14: 0000000000000000 R15: 00000000ffffffff
> [ 3854.611918]  </TASK>
> [ 3854.611917]  do_prlimit+0x91/0x220
> [ 3854.611921]  __do_sys_prlimit64+0x22d/0x300
> [ 3854.611924]  do_syscall_64+0x5d/0x90
> [ 3854.611927]  ? audit_reset_context+0x232/0x300
> [ 3854.611929]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3854.611931]  ? do_syscall_64+0x6c/0x90
> [ 3854.611933]  ? syscall_exit_to_user_mode+0x2b/0x40
> [ 3854.611936]  ? do_syscall_64+0x6c/0x90
> [ 3854.611938]  ? exc_page_fault+0x7f/0x180
> [ 3854.611941]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 3854.611943] RIP: 0033:0x7f6be3905265
> [ 3854.611956] Code: 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> 00 f3 0f 1e fa 48 89 f2 45 31 d2 89 fe b8 2e 01 00 00 31 ff 0f 05 <48>
> 3d 00 f0 f
> f ff 77 03 c3 66 90 48 8b 15 99 8a 13 00 f7 d8 64 89
> [ 3854.611957] RSP: 002b:00007ffde01fa948 EFLAGS: 00000246 ORIG_RAX:
> 000000000000
> 012e
> [ 3854.611959] RAX: ffffffffffffffda RBX: 0000560f19d93c00 RCX: 00007f6be3905265
> [ 3854.611960] RDX: 0000560f19d93c00 RSI: 0000000000000006 RDI: 0000000000000000
> [ 3854.611961] RBP: 0000560f19d89f48 R08: 000000000001f124 R09: 0000000000000000
> [ 3854.611962] R10: 0000000000000000 R11: 0000000000000246 R12: 0000560f19d85662
> [ 3854.611962] R13: 0000560f19d93cf0 R14: 0000560f19d8566d R15: 0000000000000002
> [ 3854.611964]  </TASK>
> 

