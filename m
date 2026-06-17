Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F112F585
	for <audit@vger.kernel.org>; Wed, 17 Jun 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663572; cv=pass; b=t5ZAg6FqtVYC4PvTPdP+LxqA/gWDLXRhl/6lZIiUDb3ns9qtk1CXoix4TzR0z0s+rmEfR91JLPgCQJd0AA2u6GbrQTzESAx6yMmpJnWdnka33W3p0IPWAkjb2q7P8TDZ8VzX/1IKoTzFzEQhTWCt+WGjlKGZWfeR7pdlnjSWbQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663572; c=relaxed/simple;
	bh=xG2DgqZGuUaGU3ywEUgEkhOK3PRTvPd+4WM++5gnIv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4C/LDH2+qmOo56hRyGICQ/3KBP0j0tew2mBx6/dO1J//7PKnuveYDd5LLdAhjMyQokGIbywFlFRRQZGxIgXp3GZiWlCs/QgqP9jhc6xJJQDrneSjh5k/3fGmpYft0quoo63H0hvnqmpz1BhpL2Int5sKjFLz04Y1lTKqD0P/Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G8eftUyS; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G8eftUyS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37cae11ba85so190575a91.1
        for <audit@vger.kernel.org>; Tue, 16 Jun 2026 19:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781663570; cv=none;
        d=google.com; s=arc-20240605;
        b=fnrQPEBmQpKsNiVGWbkjrDrhl8VINZgtmAQ9jCRE+UkKInYvnxdRTBnC013kzzjweF
         yT0KZjtSIQBODOSLHcVbqla741UoNqyNA/AtlbMuQmB5hIi2xQBGuML04yTPcZ+aeE+z
         nFDy9WJzzlHHqyGGwsH7VHdCr7FK+CkFtG7rF9t6ZEairXXCYaUUpFPAjaGFv+MnH5Z4
         wlVWr5aa0pCnCZms7zNvs+ba2SQ8WaplS2K/5m8XRReNCbUUGEpjZCaewEddW40Jwtyb
         HhLnPCPcUq1P6PGWVxnhISe+HGdBOtRDenPF8xAwH44Qk8kSCun5JW+Hw09Ux4XnK9Ug
         gRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        fh=BeEYyzJpsngas1R7WboilgvVkkpVUtqCqnCwoB7nepQ=;
        b=i0M+5OA1mfIiTO4WfXQD2T4KmcW/2iKMeYa/x4Mbm1YIY3DLkOXhFdd+BzxglhcnIv
         dlfiSylA5j9lnBBov0rvOiiT1K15k9gFi29c6CjHq9lMWMolbnWIMxf7FBbbSPKLaIFS
         gOuseBVHmIuNeVvOzLDDmVbTUfmakIZhkjVT+GCwpwx/KjTksCLWJG78bRJHPZv4VyIh
         xoPAci5jevXLzS/xM8HztJNTH49rkL0jwakPiX9I1pRaj74z4rKKJrTUdBkxl/2m99U3
         axQENO7s56qx3OFWP8T3pfaCnW1SBIWjPudpLSFavBZgn5ykQ3wu4QK2z6HUgW+b6lQU
         eiig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781663570; x=1782268370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        b=G8eftUySTGq/7XgDcNG8jomNAP6G2ktSJTTM6LC3CvdfdyXja4VGH+md1BO5BKAsld
         AX8t8F0SeFiPeCV9O3YQXeFtGqju8GHthCl/fbioQdYXtvLyDZClq1IoJdMS6bvnQljP
         3zsVyzxrRtUcwkWrqEcY7gPE1K2lngppCJL5T5wx52iAG4hbStVZaHR/RTMcZaJVkjBN
         MYHY3E3RohPlLttTKdqlqr5yuzWXcyEDK009qMYJcL1e7cjTq+0aFcCFjFC23EfxV03S
         RlEif/Pe08Hm7aHxboHsEGm03/82ozBV/ZbuPoreuDhjQeCs2VVdNp5N2BUuLULtfg61
         ZnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663570; x=1782268370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZTdV3B/ZTo07f/R002Ay7yCKDKVa4MK34m0NvQKlnk=;
        b=aPE18L0VLa6gdMI7JhbXWaDUkyAGV1PAAJ3AJ90tkBGX41GBlRnGVOTnv8BiJGw4l7
         ZloWD9kz7eP7cwPirzBshq6+PiJejvyRjyonrQVQR9DkfOaHdzGT/m3sp0AJq+gKOh6m
         q2qESNmTlTS+41z3rhdFU5Oh5YKALi75kde/nAZO3o0JlDLhxMssYH3T6yQ6whDykwTw
         cZ9ieqV0HZ0NYhq58+Zr6/FOgFfXo5iPfTvvMHBrL3KNuDjd3WcA3gGoYL9DXttJuA9i
         +6zw4bOsm2vcgevXR19vtFoBQmFU5lFAOtuYeWAmffiDrDoRgvIwKBGvAXOpesMWsnGJ
         xjGg==
X-Forwarded-Encrypted: i=1; AFNElJ/NJVcD+yLN6s0D0xAK+c8JlZD5dnDuwuw0WUOyR5sHJG9ZY2E8pq66SKcnlfmjDtfwthMyig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxlkkmjH62vnlSSe7jb6aFi22XcWYeygMUk7OGRGEYARQB4n+
	xPCoJUUx4+Y4ESEm7u7MNaY+HToJGECp8A64O6R8MKidaqLaDdRgwYczpEjChE/KrhlRoeAUls/
	dXtLYKQrlatD0rmmHNG+PHmY/mX7IzQV5idy6xkwW
X-Gm-Gg: Acq92OG0pyNY8mzTm0QbmOpZ4TCZb/nH6PZDyhqX/NQnSROTWHHrywo6ZTYEy5e00j3
	a24pdNVQ2fh1poONmMPj4Zji2OoqkR8JxBnKUy0RF5BFsBjkBqBZ/VC/A50hF9vbNlwSnpVurlD
	qjZCwGaYzRMFoEYZ9DiQeGrzxZn2wD+IhID5XBPU7DVX+wNmcyJqILXrRfTAxvxc3CW1JSmJm0D
	u/i94U2of8GXCU1Q0tg0busGoOZxW3h7cocbouC5R3aTbVZft6mZbxISyZX3WYt7++Zy0aA
X-Received: by 2002:a05:6a20:2d23:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3b8b5b28234mr2192226637.6.1781663569701; Tue, 16 Jun 2026
 19:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl> <20260614164438.2980769-5-jkoolstra@xs4all.nl>
 <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
In-Reply-To: <526417482.1849950.1781559782000@kpc.webmail.kpnmail.nl>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Jun 2026 22:32:37 -0400
X-Gm-Features: AVVi8CeBzQPsndw9BAmE-isUeqXVnMvX0g_IsdGEMSwro9rl0HZmb4E-x0wn-Ws
Message-ID: <CAHC9VhSBOQqjQ6A+f4YEJZmWVxVqOrRbtj7hF2qL_-vCCBc2Fg@mail.gmail.com>
Subject: Re: [PATCH 04/12] fs/namei.c: lookup_open(): move audit_inode_child() up
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:43=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
> > Op 14-06-2026 18:44 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> >
> > In the mknod(2) path of calling vfs_create() we call audit_inode_child(=
)
> > before permission checks in may_create_dentry() (but after path-based
> > LSM check). Copy this behaviour to lookup_open() and move
> > audit_inode_child() to may_o_create().
> >
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

...

> CC, audit@vger.kernel.org
>
> Went too quick with this one... audit_inode_child() probably shouldn't be=
 called
> if we are in the lookup case. So there isn't really a way to do this exac=
tly
> symmetrical to the vfs_create()/vfs_mkdir() paths.
>
> But certainly the current implementation is also wrong. In the atomic_ope=
n case
> audit_inode_child() is called only once (in the final fsnotify call in
> open_last_lookups()), but in the regular ->create case audit_inode_child(=
) is
> called twice.
>
> What behavior is actually wanted here?

I haven't looked at the VFS open/create code in a while, and I'm kinda
swamped with other things at the moment so a few pointers would go a
long way towards helping get the right context for your question.

We shouldn't *need* multiple calls into audit_inode_child() for a
given filesystem object as long as all of the information audit needs
can be captured in the single call site.

--=20
paul-moore.com
