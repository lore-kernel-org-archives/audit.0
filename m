Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220594B26F6;
	Thu,  8 Oct 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471851; cv=none; b=mFcozlTsEx+2OOWhdPcIeq1b1ss5UDQhSc7K4BYcNG38yH6M56O1Nl9fxgD0Va+aqsbCVxIKb4Fdfnx0EC62IZ+G+7Qt3JBwA1tWUnugTGO+T2XiHBue7RIhfuKsKioGyz+goOMAvowVpx3J8RFYmuNJ/tWNufUSnufj2AcUBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471851; c=relaxed/simple;
	bh=7nVuehq9hqhOZzPVbGORrV/joRhIE4rxGBzMuo0rEwo=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=D4Y+pnqx/Xo5a8pXfJSK4KimANTnP/SE1bU5R4lXXmcxSb7P+5VLb5dJlVD6dhcWpJM0m338DSTK9ms7SQxz4MUtdcjI/DHfVrL+RP30xiwmxate0dYDuQH9bn2UWHXKN62AhMpilzOsNwYinGMJNu0+iNYBgJqRWDmGagOHlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JqNBH+QM; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RroPjtJs; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JqNBH+QM";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RroPjtJs"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791471823; bh=itDO/57OykZ2Eb2iKAjB5cj
	EaU+TYede15TQYHYPsDI=; b=JqNBH+QMlfCVOGxfsqxULvija+8xZ0Ke8gXkz9D0q6vCEXpx5L
	8DQsRfNPCHNShIGBCXWmZnpP0K2UFXw+yYTd9iWYmX7qPri40bsr9uqX4lPT2FPDM6Ug2hTfh10
	saOvlOYSWGYZCNjhCBnSm9tEX91cZ82RQ/TyHoDu9HsiPClw8GmnnOe6sBf4BMsKowe/GBxLp5X
	VrMnH+B1VQ9Go723LHWTDuh7R/Y1RPLOzBySNYszIHq1QMpOwUQ8vtp/HkIAe/hzQrbISRL6qku
	bxHcN2hQNB1hT9qhrGA1knNbNOjrxa+5/vz7OLfISTajBqbCMN+ZLlNvnIpKnK8WP+A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791471823; bh=itDO/57OykZ2Eb2iKAjB5cj
	EaU+TYede15TQYHYPsDI=; b=RroPjtJsvI+kNiZ1nZDpQJuCOy6bwFCdm63YIXobz1vtQVoEtC
	CV+xOrVs8zfRDhxyTPhWcOMVl/0LzdUa98CA==;
Date: Thu, 08 Oct 2026 16:03:40 +0100
From: Bradley Morgan <brads@mainlining.org>
To: bbnpreetsingh@gmail.com
CC: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_audit=3A_annotate_the_lockl?=
 =?US-ASCII?Q?ess_read_of_the_audit_control_lock_owner?=
In-Reply-To: <20261008034403.7-1-bbnpreetsingh@gmail.com>
Message-ID: <0EFFB255-9B0D-464C-9684-72BCEF3F9A30@mainlining.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 October 2026 04:44:03 BST, Babanpreet Singh <bbnpreetsingh@gmail.com>
wrote:
>audit_ctl_owner_current() reads the lock owner without taking the lock
>and KCSAN complains about it. Only the current task can store itself as
>owner, so the check can't give a wrong answer. Mark the accesses with
>READ_ONCE() and WRITE_ONCE().
>
>Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=39b8fea0641107a1ccee
>Assisted-by: Claude:claude-opus-5-5

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10


>Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
>---
>v2: drop the comment in audit_ctl_owner_current(). The KCSAN build of
>audit.o disassembles the same as v1.
>v1: https://lore.kernel.org/all/20261002011712.7-1-bbnpreetsingh@gmail.com/
>Compile tested only (gcc W=1 and the KCSAN instrumentation diff); I
>could not reproduce the race in QEMU.
>
> kernel/audit.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/audit.c b/kernel/audit.c
>index 631d6d4a23cfd..d0c2036bde759 100644
>--- a/kernel/audit.c
>+++ b/kernel/audit.c
>@@ -247,7 +247,7 @@ int auditd_test_task(struct task_struct *task)
> void audit_ctl_lock(void)
> {
> 	mutex_lock(&audit_cmd_mutex.lock);
>-	audit_cmd_mutex.owner = current;
>+	WRITE_ONCE(audit_cmd_mutex.owner, current);
> }
> 
> /**
>@@ -255,7 +255,7 @@ void audit_ctl_lock(void)
>  */
> void audit_ctl_unlock(void)
> {
>-	audit_cmd_mutex.owner = NULL;
>+	WRITE_ONCE(audit_cmd_mutex.owner, NULL);
> 	mutex_unlock(&audit_cmd_mutex.lock);
> }
> 
>@@ -268,7 +268,7 @@ void audit_ctl_unlock(void)
>  */
> static bool audit_ctl_owner_current(void)
> {
>-	return (current == audit_cmd_mutex.owner);
>+	return (current == READ_ONCE(audit_cmd_mutex.owner));
> }
> 
> /**

Clean!

>
>base-commit: a8bdcf944504980635c2069b4a4cfcf677b09bbb
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
