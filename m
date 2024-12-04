Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D72CA9;
	Wed,  4 Dec 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281233; cv=none; b=H5uLp8s8Pk/aaJ5HsMyr+OARJZbDXIHeLptalXaQLQTsx89aHrJICTnbhlmaXiS8WE5wJ4vZLgd2rm088u2sw6/ZX0s7qV1m0GYngSBxSe3SpPpgmVVgPyNKNll2Q+wKA84Y6N88LJtTpeuu3bbc/Ir5SprXUoA22KTTDrHDdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281233; c=relaxed/simple;
	bh=RDRAVE4QPo6F/Y2h2DKGCCKwMmlOjO56h8recxRzJaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8BqH/fP1GJelCWOmkvnGJ0UOoWUeEuITmPAQHFjJZoda17seNai1YskETTHJskFvG4dU6II55fuKpfVm9URluuHRtdow9DpFYLVuj+F3b++0O0z6543rvpEvgEBcD3MPARiFcwf+AvWBJMvg756/8cxPC6NZYy71+3FF4HV5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxuNRcYM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxuNRcYM"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d87e0082b8so42236386d6.2;
        Tue, 03 Dec 2024 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281230; x=1733886030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWtav44aGPTg+SH71WZDykbhQc5sKDR+6r0BIdOJERI=;
        b=YxuNRcYMh5uc7LRoAlIfCnCehFLIt6Sp0YzFZ7Znwu03vx2M2iQ/dflnJz9yWO7Ryi
         7KKEvdjEFagcp2ogK+jMMNlqBqW5PZFGVNM07Hcg71uCgzXDDWrXOUvx2VEPGliXJQsa
         Ry50ebiE+t3KeEGzWVHANTSeg4CIsC1tyLCc4PVPAmDEPpCsxbteWraYPkyh7X6gTQ43
         S4nhN4mJKTGBs3AnK6TanzD0QYuJKiPyaNDU3aYKhn/7JbTCUJO2mDSdo/sESX40HEoR
         vDt5hJ3k5F+cLplPVtAWv11vt13c+wX5lmNeViO0EA61lXfqfrxLui/f6Rj88Hfy2b6v
         hEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281230; x=1733886030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWtav44aGPTg+SH71WZDykbhQc5sKDR+6r0BIdOJERI=;
        b=RKJuwh3RFBK5Ua/W81wJGbH6Aj8HFkmRHhJJ3WqEZCzddHm/mPHQ/ARpgIRBo5m/II
         dDMmRtI4rRW9oCqjs8QeAvL+jQow3GS351eyI54j90d6szb5pzyw/0/NasWhAOOEulgX
         PTZqMW+fuCAPBcgrXtlW30hHpTZBMvU5CnKJ6kgFdAcaDJ7eefX+V2ZMmhn3BPHWxniu
         rFFf9aL/2Kz3lzUSE33xIgQubfBYj8/MZIwvGKf4v78oWM0pnt81tm2xyL/G4rwKcckl
         D2uxYf4mU5mhOCFsaj7+PEOReaMquaK3Y5nefduPUWMsKNUkg8lX/lb4ECzNMUOC048I
         qigg==
X-Forwarded-Encrypted: i=1; AJvYcCW8b/5E7JFa9mms90LogkyJEFefNdD+3Nk5bgZhPe/H9FKxDuI2wkrLerO6jQjXnT6mF4XO4oCEw5aa8q6h@vger.kernel.org, AJvYcCWLvcinK5CuxqkbtDVjdzW+CXl7uteSnDDsjWiXO4z+CFS+kIghMK/3jA0QC/OBH6C5T0MLvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwayJPvdjM27K8u9V+IeoVdhnCFscFklAONioaCoHcLnbLVkxmT
	CQ3yz84ZTp95AuOq8bauzuz6GoWGCDa3ZEPV92VI236oSS7+nYz4S7lDT8R3QPCFgc/EFm5cX0e
	PNPhV7mJlCuG/SrbsevMhlUP1+2k=
X-Gm-Gg: ASbGncuA+Ag8+SE7gH+bPou4TMFQt4+oyEywg8YofPmUHBBdA9mXDY+tAtWn6+4uErp
	GhsJcQGbphWLzeSaJ0xcnUTKAbQ/SmOMYyw==
X-Google-Smtp-Source: AGHT+IFnywf/vYN4TukMPJc6MJF4FTs1TKly8Y7qtQnLdJa4iQXGg6E90SyigEqKtVKiJkNSusKDcdM5snxKjEeUlc8=
X-Received: by 2002:a05:6214:5008:b0:6d8:b2f2:bcb8 with SMTP id
 6a1803df08f44-6d8b7331a5dmr81140146d6.8.1733281230566; Tue, 03 Dec 2024
 19:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com> <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
In-Reply-To: <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Dec 2024 10:59:54 +0800
Message-ID: <CALOAHbDgb5LW+XF1_VHGpr7zcjenMwSQzOy-pTsyV3buOW1N6Q@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Paul Moore <paul@paul-moore.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:06=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > From: Yafang shao <laoar.shao@gmail.com>
> >
> > A build failure has been reported with the following details:
> >
> >    In file included from include/linux/string.h:390,
> >                     from include/linux/bitmap.h:13,
> >                     from include/linux/cpumask.h:12,
> >                     from include/linux/smp.h:13,
> >                     from include/linux/lockdep.h:14,
> >                     from include/linux/spinlock.h:63,
> >                     from include/linux/wait.h:9,
> >                     from include/linux/wait_bit.h:8,
> >                     from include/linux/fs.h:6,
> >                     from kernel/auditsc.c:37:
> >    In function 'sized_strscpy',
> >        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> > >> include/linux/fortify-string.h:293:17: error: call to '__write_overf=
low' declared with attribute error: detected write beyond size of object (1=
st parameter)
> >      293 |                 __write_overflow();
> >          |                 ^~~~~~~~~~~~~~~~~~
> >    In function 'sized_strscpy',
> >        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:275=
9:3:
> > >> include/linux/fortify-string.h:293:17: error: call to '__write_overf=
low' declared with attribute error: detected write beyond size of object (1=
st parameter)
> >      293 |                 __write_overflow();
> >          |                 ^~~~~~~~~~~~~~~~~~
> >
> > The issue appears to be a GCC bug, though the root cause remains
> > unclear at this time. For now, let's implement a workaround.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-lkp=
@intel.com/
> > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.loc=
al.home/
> > Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> > Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF389=
362@CY8PR11MB7134.namprd11.prod.outlook.com/
> > Originally-by: Kees Cook <kees@kernel.org>
> > Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@ke=
escook/
> > Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/auditsc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks, does anyone have a link to the GCC bug report?  We really
> should mention that in the commit description and/or metadata.

I came across a GCC bug report [0] while researching online. This
issue was reportedly fixed in GCC-12.1 [1], yet it seems the same bug
is still being triggered in GCC-14.2.0[2].
Should I file a new bug report with GCC to address this?

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101941
[1] https://gcc.gnu.org/git/gitweb.cgi?p=3Dgcc.git;h=3D76fe494230477a69f8fa=
8c8ca2d493acaf343eb1
[2] https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local.home/

--
Regards
Yafang
