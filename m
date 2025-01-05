Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DC43AA1
	for <audit@vger.kernel.org>; Sun,  5 Jan 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040236; cv=none; b=BDBkZ5DltIZe8NRtzkt2Z6gXtblcYtzdiQ8NvnVtz6fRJl9rqw1FCHcwk7r6BfxCiYa/wG7YXSdyNTtb1WLUlb3DZHR5sdaLB45z2I5R8rXIG5/YF44csgHJ7awIXVCxXJa/kFrf1Wr6S/duy5G42/ym/TkZnV3hSR5DTXLnOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040236; c=relaxed/simple;
	bh=c7iJis7Joy0QTpaOZaYBSRqrj/Rs7ZEBk6LEtw/Jnhg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UaY+I3dCIddD8GHaDRQEuDrfiO4I2YzxKEsX7LMnTDlbhLR5/z0nolZbmv4/0GUOFdB8qHGHBnt9EJJN778ci/IpTqgP4+PcQZj0kLZppoICwBz94J3/J6SCxLfMbEwkqLiC4ZIAWfRDku285bMcE2Iho3dXYiS8WYD1NopSoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A3rRtKki; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A3rRtKki"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8f916b40bso176474986d6.3
        for <audit@vger.kernel.org>; Sat, 04 Jan 2025 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040233; x=1736645033; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9qFWyzUy3S5M9WY77P7j48UYh+nD5po2O52FDMbMBA=;
        b=A3rRtKkio+XR8GmzRHxJujR7Gp/30vQPyX99XQHtAiqaGC2tCW1RaZI590rZC8OWpM
         aiDT9em69SKZ+FhcbfjJ5gc63UNbKk1DEL7orXlNs1TFFYiuyrw71gSPHxRbwT1mjmaf
         L4VLPVfrBl1+4/taClJorFvcnBaXfxpS1m74RSYSIBui6lWQG3cwg6yKVRjzHAb089Ca
         RNU03weWPp3hs9EspeTYBtDVFckRodxNKS6rOqFIhIUDIlC6F77wWCu5kNFEiVpeAWSh
         bexoOTaYYjuiEmX448A7qX+NWOKUxKuRH5IaSDxQj1sEhwZWQAAIkLcyHzXmX1xSqobw
         aPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040233; x=1736645033;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9qFWyzUy3S5M9WY77P7j48UYh+nD5po2O52FDMbMBA=;
        b=bPYhR3xkai24CiQ3b39NPxkBJ1iDUPgi6AUG6Tsk88mSqPT1aO7Dan63BzoYJqgQBm
         9oEkFmj1xJS7EWLcVFS9x1aklPvSHc0NgDVoSUINvh6JMQbe8ZkrGacs8en2uaby25Bc
         1/66kFbBAXiG1MbTk0YYhSvlvnnG1PVq/2tCC+S1BGUS+kv4pPmu1CYMjOTO6Tnnp+Pc
         6tG6BkVcRKU90cYoWjjaB86p3W3oO6cEbMUSthzKQJgV0xoAV1raLdjfc9VzHJV2f1Bc
         D8OW7vUbIc28LNp9DV81EEqTJf3hIECuF3DEvsEq0zNeFD/xvgbBDpLp49Q2Tz8Vq4Np
         Y1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrKreg45cVbdmSbBRWKcDKVoN1IIhH0aPR3WqErf8OT4BRoVba46Vw/B9C7Mk2oAan0unBVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNj/kwwzLpupu18yTWlGLE1X/UgQ6q5l3EOxJX8Agh57XG36E
	w4HpYQsCFoZC4bLiimGO153MzdX0zNQ6ZDH/lcSStDIaMRO+bhGjPrUSWON67Q==
X-Gm-Gg: ASbGncsZtc+4EyFGMuDHD1GnQuLeM4I9Nm03M47oUI1768FgbUJ5ufeqUf1TpU3a5xV
	BLvessxGIxI0Y9UM3KANf+FK+59dnUJJXIoPv4xQke4IWuh2Rqn0mspoCOEoFrnkklzv9Sud3Ii
	DFNwPSOzw6gyZH/wvxQR7lJ1Eiu9NkqdZOeFLtQxUzllyAQZYP6kTJfp+lkD5c+Q4es1wtTeP+p
	788M+uteONfwOF7U9c9yCrpFeMFkKzGGKkY3glB9hLPnKVFd+M=
X-Google-Smtp-Source: AGHT+IEfM3aRLm/9PF0Qc1flQoRYUl60QDagEdxL1nDwYw4b8FPGKr14fDWDrH+KqR5s+N9tE84JXw==
X-Received: by 2002:ad4:5baa:0:b0:6d4:22d4:f5b0 with SMTP id 6a1803df08f44-6dd2338d333mr861831456d6.33.1736040232663;
        Sat, 04 Jan 2025 17:23:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaa0csm157113306d6.5.2025.01.04.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:52 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:51 -0500
Message-ID: <237bfe2be7b4ba5d59b3b832c23622bb@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 10/23] landlock: Log domain properties and release
References: <20241122143353.59367-11-mic@digikod.net>
In-Reply-To: <20241122143353.59367-11-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> TODO: Update sample with audit's creation time and now-removed parent
> hierarchy
> 
> Asynchronously log domain information when it first denies an access.
> This minimize the amount of generated logs, which makes it possible to
> always log denials since they should not happen (except with the new
> LANDLOCK_RESTRICT_SELF_LOGLESS flag).  These records are identified by
> AUDIT_LANDLOCK_DOM_INFO.
> 
> Log domain deletion with the AUDIT_LANDLOCK_DOM_DROP record type when
> a domain was previously logged.  This makes it possible for user space
> to free potential resources when a domain ID will never show again.
> 
> The logged domain properties include:
> - the domain ID
> - creation time
> - its creator's PID
> - its creator's UID
> - its creator's executable path (exe)
> - its creator's command line (comm)
> 
> This require each domain to save some task properties at creation time:
> time, PID, credentials, exe path, and comm.
> 
> It should be noted that we cannot use audit event's serial numbers
> because there may not be any related event.  However, it is still useful
> to use the same potential timestamp instead of a close one.  What really
> matter is how old the related Landlock domain is, not the uniquiness of
> the creation time.  If audit is not enabled, Landlock creates its own
> timestamp.  This timestamp will be exposed to user space with a future
> unprivileged interface.
> 
> Audit event sample for a first denial:
> 
>   type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=LL_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

As mentioned in patch 9/23, I don't want subsystems external to audit
to access the audit timestamp information, so the "creation=" field
in the audit event would need to be removed.  Assuming that the timestamp
was used either to reference the original domain creation and/or simply
provide some additional information for analysis, all of that information
should already be in the audit log, assuming of course that you are
logging domain creation (which you should, at least as an option).

Also, is there a good reason why the LL_DOM_INFO information can't be
recorded in the LL_DENY (or LL_ACCESS) record?  I think that would be
preferable.

> Audit event sample for logged domains deletion:
> 
>   type=LL_DOM_DROP msg=audit(1732186800.393:45): domain=195ba459b
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.net
> ---
> Questions:
> - Should we also log the creator's loginuid?
> - Should we also log the creator's sessionid?

Creation of a Landlock domain can only happen through the Landlock
syscalls, yes?  If so, that information should already be logged in
the associated syscall record (see the "auid=" and "ses=" fields )and
we generally try to avoid duplicating information across records in
the same audit event.

> Changes since v2:
> - Fix docstring.
> - Fix log_status check in log_hierarchy() to also log
>   LANDLOCK_LOG_DISABLED.
> - Add audit's creation time to domain's properties.
> - Use hexadecimal notation for domain IDs.
> - Remove domain's parent records: parent domains are not really useful
>   in the logs.  They will be available with the upcoming introspection
>   feature though.
> - Extend commit message with audit's timestamp explanation.
> 
> Changes since v1:
> - Add a ruleset's version for atomic logs.
> - Rebased on the TCP patch series.
> - Rename operation using "_" instead of "-".
> - Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
> - Only log when audit is enabled, but always set domain IDs.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Remove race condition when logging ruleset creation and logging
>   ruleset modification while the related file descriptor was already
>   registered but the ruleset creation not logged yet.
> - Fix domain drop logs.
> - Move the domain drop record from the previous patch into this one.
> - Do not log domain creation but log first domain use instead.
> - Save task's properties that sandbox themselves.
> ---
>  include/uapi/linux/audit.h   |  2 +
>  security/landlock/audit.c    | 74 ++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h    |  7 ++++
>  security/landlock/domain.c   | 41 ++++++++++++++++++++
>  security/landlock/domain.h   | 43 +++++++++++++++++++++
>  security/landlock/ruleset.c  |  7 ++++
>  security/landlock/ruleset.h  |  1 +
>  security/landlock/syscalls.c |  1 +
>  8 files changed, 176 insertions(+)
> 
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

See my comment about regarding AUDIT_LANDLOCK_DOM_INFO.

Similar to my previous comments regarding AUDIT_LANDLOCK_DENY, it might
be a good idea to change AUDIT_LANDLOCK_DOM_DROP to simply
AUDIT_LANDLOCK_DOM and use an "op=" field to indicate a drop, creation,
or other event.

> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index eab6b3a8a231..2d0a96797dd4 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -8,8 +8,11 @@
>  #include <kunit/test.h>
>  #include <linux/audit.h>
>  #include <linux/lsm_audit.h>
> +#include <linux/pid.h>
> +#include <linux/uidgid.h>
>  
>  #include "audit.h"
> +#include "cred.h"
>  #include "domain.h"
>  #include "ruleset.h"
>  
> @@ -30,6 +33,41 @@ static void log_blockers(struct audit_buffer *const ab,
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

It seems like you might want to move the WARN_ON assertion up with the
other WARN_ON check?

> +	audit_log_format(ab, "domain=%llx creation=%llu.%03lu pid=%d uid=%u",
> +			 node->id,
> +			 /* See audit_log_start() */
> +			 (unsigned long long)node->creation.tv_sec,
> +			 node->creation.tv_nsec / 1000000, pid_nr(node->pid),
> +			 from_kuid(&init_user_ns, node->cred->uid));
> +	audit_log_d_path(ab, " exe=", &node->exe);
> +	audit_log_format(ab, " comm=");
> +	audit_log_untrustedstring(ab, node->comm);
> +	audit_log_end(ab);
> +
> +	/*
> +	 * There may be race condition leading to logging of the same domain
> +	 * several times but that is OK.
> +	 */
> +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> +}
> +
>  static struct landlock_hierarchy *
>  get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
>  {

--
paul-moore.com
