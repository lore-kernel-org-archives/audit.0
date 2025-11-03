Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8B30101B
	for <audit@vger.kernel.org>; Mon,  3 Nov 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167822; cv=none; b=inHj1GwVxVXSGe5k1jUStqkqVHjjiqxWoCSxe18nFoF5GUyY4PIdom+q/3xU8b+SmeVHNr4hzP1zKH+SWvl8R94bBqI1PA1JyUW3dOtqrKauuYZmddEEB2B98nuM5UV0gpdXCNx/wefjm7cfqMxbpx0tUH73G9e6EfJ+Xsm8KO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167822; c=relaxed/simple;
	bh=ZWKf1U4K8p8K7ajfbNKacDFOZXuDZuDDSYcIrkzA/N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htUqT/Tuvr+lT/sv0SlYviwqcc2dpBQJFBfJgfz6J4JQVRk6k0xYK46v+YgOBtVE/biaMksjzczV1gX4pKxUjK8OXVa6C6I+VUbAwRbFdaw1VDSV+vmvhswvuaGl8z8O+5Qw6IMzCOYz3Gxg/eLr9wOH6PbLu6FZ/gY4QEskLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLpKJjMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLpKJjMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762167818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhTdrnjfA8ppQxzFb9fDiTAH4jVhlOQqvIRjACG6oMI=;
	b=MLpKJjMHTCdfOR887lG2W/Q4X1F7KbQeodS1RVyPPdKXYOF6B33p0AfsBQjL8S/GvonI8R
	AOdytDZYCtAeqpZOzS9oS0HLCRc63aW2AVYztjkjyQsHVKVeZf/AwFecPYMldetVCQsSAB
	koSNVOD3MTqR7Ha8tZ6JeFcLtsGtcpU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5eK03voaNGCNbOwyVvykfw-1; Mon, 03 Nov 2025 06:03:35 -0500
X-MC-Unique: 5eK03voaNGCNbOwyVvykfw-1
X-Mimecast-MFC-AGG-ID: 5eK03voaNGCNbOwyVvykfw_1762167814
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b1778687so67515566b.0
        for <audit@vger.kernel.org>; Mon, 03 Nov 2025 03:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167814; x=1762772614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhTdrnjfA8ppQxzFb9fDiTAH4jVhlOQqvIRjACG6oMI=;
        b=Ko9FW5OxFryF+quV/uInf58Y7/bOpf9/Qhob4TUM9VWpTI2I1RY/BkqB7Koxvq/AQJ
         E4YNxzjg2BfeVNCD9jLsstrbYNAB9/NreneEx8bf016pJrIgtZ6vMrTaZwDX7xC2LbZm
         UVMkZmgbDMdkTwqha1YUGFpgQv2ap3qDSDVhUtH2jJeSOdJSJ/iRI8Zymt1fUazq5itu
         yANVQK8YljFz5WOSyEvqCc8g6yTnD7XQ91MZCU2eABbesv4yImLrpUz1xad2rAXavCV8
         BI1tSjxie4tu6a61zTv369iH8Fz43cFi5q0FkSjq+0+V2dF/vAPleuiqUVeNzjCU7oBK
         JIIA==
X-Gm-Message-State: AOJu0YzIvRX2v5F/ta/Ioq4q7suRpbHpPrz5U7E+yBiQ/Kjfndp4/JJH
	M+5EotPw+V/E/RqTldyC0saMpFDBJLl4Z14ervyKNkUhkFXA1XZFURzf4Fd8W8rPHrGc7Uqr5Jx
	qX/PZ6JvbXIX7XiAid1iJtdRpYdZgw3buu+CtZWzP8iba/Z04x8iZTPxkjWsDyVP6+wHlj96C7x
	SRVQjkF/Fcvpt3snNDbSYLzsrH9i7PE+o=
X-Gm-Gg: ASbGncsxgcXcej9P9NlyBW8xCql5Ps/omUSO723r6yVE2ydDB/Klnvqg+lDWpww5k8U
	S9uX/wiqY4hPqoTJOxlV2l/Kt3uAH+7glK1It3+u55tKDx14lV19EPWKDy5oCQiRL+pP+a0u/kv
	FlRv8gxGO2FrlVs+x2lS+56yWKA1oUdPJzjtZY3U51maag3xN6KGmyaBo=
X-Received: by 2002:a17:907:1c93:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b70700bad7dmr1398097166b.2.1762167814130;
        Mon, 03 Nov 2025 03:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF70Lv5L7m6M605bcYwYl5gdYYQmJQe9fOmppY9gxiQqdJv0qTmTVSWhGn8kw4mBFNTlWE3YlDmM/dVhBYh+OE=
X-Received: by 2002:a17:907:1c93:b0:b40:8deb:9cbe with SMTP id
 a640c23a62f3a-b70700bad7dmr1398093866b.2.1762167813668; Mon, 03 Nov 2025
 03:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfafc5247fbfcd2561de16bcff67c1afd5676c9e.1761918165.git.rrobaina@redhat.com>
 <202511012016.TaXzGDDi-lkp@intel.com>
In-Reply-To: <202511012016.TaXzGDDi-lkp@intel.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 3 Nov 2025 08:03:22 -0300
X-Gm-Features: AWmQ_bnNelXrYhZN2hvHONfShTGA5EvaaCJcqVosrEermFLRrvdG6VLVDrGvFk4
Message-ID: <CAABTaaCf+5mY8gze4Ojy2fttEuuEtjj3Zm1dHScXVfWtKAQbSQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] audit: add audit_log_packet_ip4 and
 audit_log_packet_ip6 helper functions
To: kernel test robot <lkp@intel.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	oe-kbuild-all@lists.linux.dev, paul@paul-moore.com, eparis@redhat.com, 
	fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qg6FtSRePjCFj3xRXjeMnAFpHGRCKWchEG4CukhfM2g_1762167814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't get these warning messages in my local build. I'll fix it and
submit a new version.

On Sat, Nov 1, 2025 at 10:15=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Ricardo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on pcmoore-audit/next]
> [also build test ERROR on netfilter-nf/main nf-next/master linus/master v=
6.18-rc3 next-20251031]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Robaina/au=
dit-add-audit_log_packet_ip4-and-audit_log_packet_ip6-helper-functions/2025=
1031-220605
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git=
 next
> patch link:    https://lore.kernel.org/r/cfafc5247fbfcd2561de16bcff67c1af=
d5676c9e.1761918165.git.rrobaina%40redhat.com
> patch subject: [PATCH v4 1/2] audit: add audit_log_packet_ip4 and audit_l=
og_packet_ip6 helper functions
> config: m68k-defconfig (https://download.01.org/0day-ci/archive/20251101/=
202511012016.TaXzGDDi-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251101/202511012016.TaXzGDDi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511012016.TaXzGDDi-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/netfilter/nft_log.c: In function 'nft_log_eval_audit':
> >> net/netfilter/nft_log.c:48:31: error: implicit declaration of function=
 'audit_log_packet_ip4'; did you mean 'audit_log_capset'? [-Wimplicit-funct=
ion-declaration]
>       48 |                         fam =3D audit_log_packet_ip4(ab, skb) =
? NFPROTO_IPV4 : -1;
>          |                               ^~~~~~~~~~~~~~~~~~~~
>          |                               audit_log_capset
> >> net/netfilter/nft_log.c:51:31: error: implicit declaration of function=
 'audit_log_packet_ip6'; did you mean 'audit_log_capset'? [-Wimplicit-funct=
ion-declaration]
>       51 |                         fam =3D audit_log_packet_ip6(ab, skb) =
? NFPROTO_IPV6 : -1;
>          |                               ^~~~~~~~~~~~~~~~~~~~
>          |                               audit_log_capset
>
>
> vim +48 net/netfilter/nft_log.c
>
>     28
>     29  static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
>     30  {
>     31          struct sk_buff *skb =3D pkt->skb;
>     32          struct audit_buffer *ab;
>     33          int fam =3D -1;
>     34
>     35          if (!audit_enabled)
>     36                  return;
>     37
>     38          ab =3D audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_=
PKT);
>     39          if (!ab)
>     40                  return;
>     41
>     42          audit_log_format(ab, "mark=3D%#x", skb->mark);
>     43
>     44          switch (nft_pf(pkt)) {
>     45          case NFPROTO_BRIDGE:
>     46                  switch (eth_hdr(skb)->h_proto) {
>     47                  case htons(ETH_P_IP):
>   > 48                          fam =3D audit_log_packet_ip4(ab, skb) ? N=
FPROTO_IPV4 : -1;
>     49                          break;
>     50                  case htons(ETH_P_IPV6):
>   > 51                          fam =3D audit_log_packet_ip6(ab, skb) ? N=
FPROTO_IPV6 : -1;
>     52                          break;
>     53                  }
>     54                  break;
>     55          case NFPROTO_IPV4:
>     56                  fam =3D audit_log_packet_ip4(ab, skb) ? NFPROTO_I=
PV4 : -1;
>     57                  break;
>     58          case NFPROTO_IPV6:
>     59                  fam =3D audit_log_packet_ip6(ab, skb) ? NFPROTO_I=
PV6 : -1;
>     60                  break;
>     61          }
>     62
>     63          if (fam =3D=3D -1)
>     64                  audit_log_format(ab, " saddr=3D? daddr=3D? proto=
=3D-1");
>     65
>     66          audit_log_end(ab);
>     67  }
>     68
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

