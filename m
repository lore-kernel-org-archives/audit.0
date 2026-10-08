Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D9359A66
	for <audit@vger.kernel.org>; Thu,  8 Oct 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431295; cv=none; b=nRElaWtcKKQd7xTclpEPOSeyoa9xTb2KfvhERjiEioOrX9UmLXVguUpP6cbhZJ/CkrESwHey4IZhe3o3bamyf1PgfxB5UCP2x37rM3AqU/bjdE2U0mPWk0/pspDL/HbU1T71yjU5HeU6eYeqaH4bTAe8eWYHi5/j0YiW2KiCEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431295; c=relaxed/simple;
	bh=bbB1oNDRvKZO2PCkMnaJjcFVFrvS8LqQ3DLP1uTG2Mk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=apQsALWY6ZN+ftLWuUzZPMcn+yNLcu1jB6PehrZ8zt+5zlEfqfHr0/ue2k9WWiPkBQU11M9Q7Od9uVGLH7S4AooHbnSyOnmt2ZHul6t90yng+kleHWZrt8tI1w+mFDifQj3KK6VeeYj1LmJGmnjqcTev+ywUmBYqq/jiZpf9KVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1cseaiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1cseaiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F11F000FF
	for <audit@vger.kernel.org>; Thu,  8 Oct 2026 03:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431294;
	bh=bbB1oNDRvKZO2PCkMnaJjcFVFrvS8LqQ3DLP1uTG2Mk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=C1cseaiNYvW5ebRgY7cy9LqklHIh9ObgrQ1bj1RPBMSaP7W1RCm4kpeVykw64Y0rZ
	 223nMGOM6UQhzxE3WcEX5nVV6AxmbrWPlgOUUyemNr9jsGf+b/qVjPnAPoT0oCHiWg
	 MNmIDov+XxNwMPaco5zSRKh8+jZLGyDyJCtrRtSiofcmmXn8Ysx7nEM4h5ppujdqPX
	 kOmTvyPYgkLOh4Iak9n+QTQhkvXe0dm5EX8aaUHLYTR2nwzbVgNyuHJBA94Mz8h3e1
	 lyH42Y1RHEP50+Zc5rTvEqKkhv0cnxWQWnyIiwNdmheoWr8gh51ge5MbcJvPOwSTr8
	 M29oEHDOd0nTQ==
Message-ID: <sashiko-outbox-163582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] audit: annotate the lockless read of the audit
 control lock owner
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20261008034403.7-1-bbnpreetsingh@gmail.com>
References: <20261008034403.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:48:13 +0000
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

> audit_ctl_owner_current() reads the lock owner without taking the lock
> and KCSAN complains about it. Only the current task can store itself as
> owner, so the check can't give a wrong answer. Mark the accesses with
> READ_ONCE() and WRITE_ONCE().
>=20
> Reported-by: syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D39b8fea0641107a1ccee
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008034403.7-1-=
bbnpreetsingh@gmail.com?part=3D1

