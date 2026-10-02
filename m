Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF0476041
	for <audit@vger.kernel.org>; Fri,  2 Oct 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932468; cv=none; b=aoUUDEPXLH+2y1joZDA8oolJaM6nl7JfAdGQLexw0z0uvvxYhyrVi7jxC8ubR4dB97BnCIJPWkOsRZYU1IMNSYClFKtTK6zcbov2Ny6DxXxCu478krq12mL0s+VzAgJwlzz1mxJquDUD+UNKdznEfRjZ/Zn5uzBP4VPPUfwf9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932468; c=relaxed/simple;
	bh=wXmun5MOZS1EWSv2nmlPO4NTuV5gilXl44YPsdg3tMg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mT0JzbDujU+2DJ9Cw9YlIYdMZ7vO4RP4XA8hvifoP03hP6BLJBtXeSBjMVgx+xqkFShI5RAmFbsOdZTzjaLSTqZGyRO1B6XJS4SecsjoGsF83H2R7mmh9pYnAlPc81VcgZWuWEzTuqD3S345hEfN81+Uid8CQcluU0GpcEYMHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqgZvgDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqgZvgDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E611F0089A
	for <audit@vger.kernel.org>; Fri,  2 Oct 2026 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932467;
	bh=wXmun5MOZS1EWSv2nmlPO4NTuV5gilXl44YPsdg3tMg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HqgZvgDE7zYC7HHMz7udmGlGwEw1T1/efrLlrHUXPxcEo1Cl+UYiH9d9KRzpcDacs
	 Lidjzwx90DufrOTvczJe/8ey+lgGTu88WCg1YJHhZYyIN+hIorwXsIYfKUxqOgu6G4
	 Q81ZaOigvPWG5vWVjaGK6/UzotgfL6HfRv6qWG8/16PeqbWPi5TXJsdexuauhtyBvC
	 agaZqaB9jEQ35dA/zOksaTa7Wn/Pie5rJH1qDve712DHPAHpgvr4xmLm/Z8Sem+drB
	 nqxm0V1LFulvZaNUyt7zeX37ehuVCmd7/iPYwBW6VVCm28TKOHiPIRX2B3w3c0Ms1N
	 pDYmcGi4wSgyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] audit: annotate the lockless read of the audit control
 lock owner
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20261002011712.7-1-bbnpreetsingh@gmail.com>
References: <20261002011712.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:27 +0000
Message-Id: <20261002091427.88E611F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002011712.7-1-=
bbnpreetsingh@gmail.com?part=3D1

