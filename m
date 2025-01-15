Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78C1DDA34
	for <audit@vger.kernel.org>; Wed, 15 Jan 2025 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985191; cv=none; b=LWZL50O5vOsFC872J7Zo3uIs+OJQIHWM6FZwRcUUHq8zXFxtvGDOd7Ebdv1dRjcPveLybB5jxkkZC/F/epUAdpq3ncxCMVVO4rCY929HiPmkx19j5g0FHfGn7/xyQUiLzDaYyTDoc0LRqv9CXBb4cC7UapSiOTLLgZ0AyQ6Bz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985191; c=relaxed/simple;
	bh=IjabEPs0I4hNYHkgGdzWVBCCcYQiwr0PX253DxcEMBA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=OIP0gwZOSys96L4750dlkGuwmGF962qLSBSPdIN1rYS0iRHq3KyUNucjFfuCXjrHT0ggUuAttpHv/TyH5Hhuukq8wTqCx6ovIJG61hurq671PT03TWttP+8y44UjHB9kHuTR6hMzLpj0J93bHRWDYH/oDjMQdEqxPya5KHnjdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SUgCBt8d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SUgCBt8d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f1b54dc3so53116785a.1
        for <audit@vger.kernel.org>; Wed, 15 Jan 2025 15:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736985188; x=1737589988; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMPFbikgUnRgHwWdcFDsLokvyAaCPmB7VxOaO1AMn/I=;
        b=SUgCBt8dO0bsySLaoyUhEH9xSbIUQk5pIulbhRoVZ80ddRYo/22u0nFGiIyv6rYFDe
         FVciVqUY4SY/ePB5kMi5b2V6jmGO9mgv4JskA29r/4I1OnnATNEGCkVvlvfbqlPNBVgQ
         KOAcou592kfRCaE2DTHpZqpl2EKwRaf7g0SVHKD5pmbXdfNweppXID8YUvdTvVxUY3Ze
         iyC2B1ORiy+dAtZMLCgKK1bLXRf/juhHurtYbU8EKwilE66BogXaQWJIPNhq96ouZzzR
         W7SenaNE+1lTsrpBejwGRrtKXxmpFy2TuzuxWFYD1nrBldD7lZXgsFlNKcyybKxJgNXQ
         m6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985188; x=1737589988;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMPFbikgUnRgHwWdcFDsLokvyAaCPmB7VxOaO1AMn/I=;
        b=hsu7p0MnllUXXfmVIwWNdGSYIAIF8hnNlS8R9kC4tN5Tae00hXB3+2Vttps2BTlQFx
         AdLDVseHeMDfir1A/Lv9lcNFsUnm+IuDLcF3yFRGqiNmoDDZqFWFVEIwhRcgT7MLAMVn
         pVaaIGeyHOJhbiit0XMA16JSaZxZFEG8+x9Qyf0rGG4bBQJc2sTw3fftQeE+JWt/v2xx
         SF5tbYVt1dxjVl6fgNkYSr9xVVXrAPOWKN2nev5EnBpe5rOSo2qlHwrs/R6rpxJVeG2j
         cL6vH8GVO53Z+4g/TysdeUAh07wfflBrwk5GMMkEHEOB4ipQ+y4Ax/qtd6RqCF07b38A
         yK4A==
X-Forwarded-Encrypted: i=1; AJvYcCWdbKrYTpF/Dur7X6u6QP5PdIRn3oGsK2dacmWcha892B8/q0MgDGjaXNQ+DEXqpcT0fZze/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRtF9JjI+irEx3M2gyxfTaqDadTP79MVqGLtPT8yZw/RPPF7x
	tqnRsLCFuD3GWkxpV+bVeN4greJ8pn3aRhdYKEVNuI7iRWwj2aQvvsb7yRQ6Jg==
X-Gm-Gg: ASbGncvAJkfgNC4ilRtRpt6rb0REiP736w2FK7nJ0kvecYwSa2udBATPig61huPMrzl
	hWCL02PY9s7ON/qkyCfUPAmmp2QZrboWPdapvdsTn1D1KvBWPVsXiO/bHJHYrbZbuKhGwS1bUJ7
	wa/0nZIQzCQ8/VinCApQ35YGhcPg0wIBVVTU+iJ/9o2VWRp1R6kI1JI60uSJaa7egpu5vVrcup4
	6PmrJMjHtrjJGqtoek7N380/mitVly95wyUbkqTO6nj/9uIxw0=
X-Google-Smtp-Source: AGHT+IHuFsbyq9Y/tzxO03I3cjYigkJG8pw4nUDpN6wUv/2ZNeRVRowyABfLHteGVlW4iSQ6uqljBg==
X-Received: by 2002:a05:620a:84c3:b0:7a9:b914:279c with SMTP id af79cd13be357-7bcd961c2e5mr4565556185a.0.1736985188295;
        Wed, 15 Jan 2025 15:53:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7bce3502a56sm768094385a.91.2025.01.15.15.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:53:07 -0800 (PST)
Date: Wed, 15 Jan 2025 18:53:07 -0500
Message-ID: <1a169f22750aec9db4d7a377a4f99733@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250115_1512/pstg-lib:20250114_2216/pstg-pwork:20250115_1512
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 9/30] landlock: Add AUDIT_LANDLOCK_DOM_{INFO,DROP} and  log domain properties
References: <20250108154338.1129069-10-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-10-mic@digikod.net>

On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Asynchronously log domain information when it first denies an access.
> This minimize the amount of generated logs, which makes it possible to
> always log denials since they should not happen (except with the new
> LANDLOCK_RESTRICT_SELF_QUIET flag).  These records are identified with
> the new AUDIT_LANDLOCK_DOM_INFO type.
> 
> The AUDIT_LANDLOCK_DOM_INFO message contains:
> - the "domain" ID which is described,
> - the "creation" time of this domain,
> - a minimal set of properties to easily identify the task that loaded
>   the domain's policy with landlock_restrict_self(2): "pid", "uid",
>   executable path ("exe"), and command line ("comm").
> 
> This requires each domain to save these task properties at creation
> time in the new struct landlock_details.  A reference to the PID is kept
> for the lifetime of the domain to avoid race conditions when
> investigating the related task.  The executable path is resolved and
> stored to not keep a reference to the filesystem and block related
> actions.  All these metadata are stored for the lifetime of the related
> domain and should then be minimal.  The required memory is not accounted
> to the task calling landlock_restrict_self(2) contrary to most other
> Landlock allocations (see related comment).
> 
> The AUDIT_LANDLOCK_DOM_INFO record follows the first AUDIT_LANDLOCK_DENY
> record for the same domain, which is always followed by AUDIT_SYSCALL
> and AUDIT_PROCTITLE.  This is in line with the audit logic to first
> record the cause of an event, and then add context with other types of
> record.
> 
> Audit event sample for a first denial:
> 
>   type=LANDLOCK_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=LANDLOCK_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> Audit event sample for a following denial:
> 
>   type=LANDLOCK_DENY msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
>
> Log domain deletion with the new AUDIT_LANDLOCK_DOM_DROP record type
> when a domain was previously logged.  This makes it possible for log
> parsers to free potential resources when a domain ID will never show
> again.
> 
> The AUDIT_LANDLOCK_DOM_DROP message contains:
> - the "domain" ID which is being freed,
> - the number of "denials" accounted to this domain, which is at least 1.
> 
> The number of denied access requests is useful to easily check how many
> access requests a domain blocked and potentially if some of them are
> missing in logs because of audit rate limiting or audit rules.  Rate
> limiting could also drop this record though.

Wait, what rate limiting?  Landlock shouldn't be adding any audit event
rate limiting beyond the queue management knobs built into the audit
subsystem.  If you are comfortable rate limiting the logging of an event
it is a good sign that it probably shouldn't be an audit event.

The audit subsystem is for security releveant events, not diagnostic,
debugging, or other "nice to know" messages.

> Audit event sample for a deletion of a domain that denied something:
> 
>   type=LANDLOCK_DOM_DROP msg=audit(1732186800.393:46): domain=195ba459b denials=2

As mentioned earlier, I don't like the number of different Landlock
specific audit record types that are being created.  I'm going to
suggest combining the LANDLOCK_DOM_INFO and LANDLOCK_DOM_DROP
records into one (LANDLOCK_DOM?) and using an "op=" field to indicate
creation/registration or destruction/unregistration of the domain ID.

> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-10-mic@digikod.net
> ---
> Questions about AUDIT_LANDLOCK_DOM_INFO messages (keeping in mind that
> each logged metadata may need to be stored for the lifetime of each
> domain):
> - Should we also log the initially restricted task's loginuid?
> - Should we also log the initially restricted task's sessionid?

...

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 60c909c396c0..a72f7b3403be 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -147,6 +147,8 @@
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
>  #define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
> +#define AUDIT_LANDLOCK_DOM_INFO	1424	/* Landlock domain properties */
> +#define AUDIT_LANDLOCK_DOM_DROP	1425	/* Landlock domain release */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index d90680a5026a..ccc591146f8a 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -8,6 +8,8 @@
>  #include <kunit/test.h>
>  #include <linux/audit.h>
>  #include <linux/lsm_audit.h>
> +#include <linux/pid.h>
> +#include <linux/uidgid.h>
>  
>  #include "audit.h"
>  #include "domain.h"
> @@ -30,6 +32,43 @@ static void log_blockers(struct audit_buffer *const ab,
>  	audit_log_format(ab, "%s", get_blocker(type));
>  }
>  
> +static void log_node(struct landlock_hierarchy *const node)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (WARN_ON_ONCE(!node))
> +		return;
> +
> +	/* Ignores already logged domains.  */
> +	if (READ_ONCE(node->log_status) == LANDLOCK_LOG_RECORDED)
> +		return;
> +
> +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> +			     AUDIT_LANDLOCK_DOM_INFO);
> +	if (!ab)
> +		return;
> +
> +	WARN_ON_ONCE(node->id == 0);
> +	audit_log_format(
> +		ab,
> +		"domain=%llx creation=%llu.%03lu pid=%d uid=%u exe=", node->id,
> +		/* See audit_log_start() */
> +		(unsigned long long)node->details->creation.tv_sec,
> +		node->details->creation.tv_nsec / 1000000,
> +		pid_nr(node->details->pid),
> +		from_kuid(&init_user_ns, node->details->cred->uid));
> +	audit_log_untrustedstring(ab, node->details->exe_path);
> +	audit_log_format(ab, " comm=");
> +	audit_log_untrustedstring(ab, node->details->comm);
> +	audit_log_end(ab);

I'm still struggling to understand why you need to log the domain's
creation time if you are connecting various Landlock audit events for a
single domain by the domain ID.  To be clear, I'm not opposed if you
want to include it, it just seems like there is a disconnect between
how audit is typically used and what you are proposing.

> +	/*
> +	 * There may be race condition leading to logging of the same domain
> +	 * several times but that is OK.
> +	 */
> +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> +}
> +

--
paul-moore.com
